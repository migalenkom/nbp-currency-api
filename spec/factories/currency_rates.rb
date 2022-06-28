FactoryBot.define do
  factory :currency_rate do
    date { Time.zone.today }
    code { 'USD' }
    name { 'U.S. dollar' }
    avg { '5.5555' }
  end
end
