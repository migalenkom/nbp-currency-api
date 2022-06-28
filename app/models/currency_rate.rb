class CurrencyRate < ApplicationRecord
  validates :code, :date, :avg, :name, presence: true
  validates :date, uniqueness: { scope: :code }
end
