class CreateBillingInfo < ActiveRecord::Migration[5.2]
  def change
    create_table :billings do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :institution, null: false
      t.string :credit_card_number, null: false
      t.string :credit_expiary_date, null: false
      t.string :cvv, null: false
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :province
      t.string :phone
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
