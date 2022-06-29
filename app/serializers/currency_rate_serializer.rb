class CurrencyRateSerializer
  include JSONAPI::Serializer
  attributes :date, :name, :code, :avg
end
