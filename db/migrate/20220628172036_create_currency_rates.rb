class CreateCurrencyRates < ActiveRecord::Migration[7.0]
  def change
    create_table :currency_rates do |t|
      t.date :date, index: true, null: false
      t.string  :code, null: false
      t.string  :name, null: false
      t.decimal :avg, precision: 8, scale: 2
      t.index %i[date code], unique: true

      t.timestamps
    end
  end
end
