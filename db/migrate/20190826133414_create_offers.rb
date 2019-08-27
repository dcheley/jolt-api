class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.string :title, null: false
      t.string :category
      t.decimal :dollar_value, precision: 8, scale: 2
      t.date :expiary_date
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
