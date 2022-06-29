module Api
  module V1
    class ExchangeratesController < ApplicationController
      before_action :validate_dates, only: [:index]

      def index
        @rates = CurrencyRate.all
        @rates = filter_rates

        render json: CurrencyRateSerializer.new(@rates)
      end

      private

      def validate_dates
        %i[from to].map do |date|
          next unless params[date].present?

          Date.parse(params[date])
        end
      end

      def filter_rates
        @rates = filter_by_code(params[:code])
        @rates = filter_by_date_range(params[:from], params[:to])
      end

      def filter_by_code(code)
        return @rates if code.blank?

        @rates.where('LOWER(code)= ?', code.downcase)
      end

      def filter_by_date_range(from, to)
        from = from.presence || Date.today - 1.day
        to = to.presence || Date.today
        @rates.where('date >= ? AND date <= ?', from, to)
      end
    end
  end
end
