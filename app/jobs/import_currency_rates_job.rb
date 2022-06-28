# frozen_string_literal: true

class ImportCurrencyRates
  include Sidekiq::Job
  sidekiq_options retry: 2

  def perform
    NbpApi.new.call
  end
end
