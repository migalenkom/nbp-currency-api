require 'rails_helper'

RSpec.describe CurrencyRate, type: :model do
  let(:currency_rate) { build :currency_rate }
  let(:second_currency_rate) { build :currency_rate }

  it 'validates currency rate' do
    expect(currency_rate).to be_valid
  end

  it 'invalid without code' do
    currency_rate.code = nil
    expect(currency_rate).not_to be_valid
  end

  it 'invalid without date' do
    currency_rate.date = nil
    expect(currency_rate).not_to be_valid
  end

  it 'invalid without avg' do
    currency_rate.avg = nil
    expect(currency_rate).not_to be_valid
  end

  it 'invalid without name' do
    currency_rate.name = nil
    expect(currency_rate).not_to be_valid
  end

  it 'invalid when duplicate' do
    expect(currency_rate).to be_valid
    currency_rate.save!
    expect(second_currency_rate).not_to be_valid
  end
end
