# frozen_string_literal: true

class NbpApi
  BASE_URL = 'http://api.nbp.pl/api/exchangerates/tables/'

  def call
    %w[A B].each do |table|
      import_table(table)
    end
  end

  private

  def import_table(name = 'A')
    result = request(name)
    return Rails.logger.error("NBP import error #{result.inspect}") unless result&.success?

    json = parse_result(result)
    return unless json

    @rates = json.dig(0, 'rates')
    @date = json.dig(0, 'effectiveDate').to_datetime
    transaction = CurrencyRate.insert_all(prepare_attributes)
    Rails.logger.info("imported: #{transaction.count}")
  end

  def parse_result(result)
    JSON.parse(result.body)
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse result #{e.message}")
    nil
  end

  def request(path)
    Faraday.new(url: "#{BASE_URL}#{path}", headers: headers).get
  rescue StandardError => e
    Rails.logger.error("Request error: #{e.message}")
    nil
  end

  def headers
    { Accept: 'application/json' }
  end

  def prepare_attributes
    @rates.map do |currency|
      {
        name: currency['currency'],
        avg:  currency['mid'],
        date: @date,
        code: currency['code']
      }
    end
  end
end
