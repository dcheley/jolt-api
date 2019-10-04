class AddColumnsMultipleTables < ActiveRecord::Migration[5.2]
  def change
    rename_column :billings, :credit_expiary_date, :credit_expiry_date
    rename_column :advertisements, :expiary_date, :expiry_date
    rename_column :offers, :expiary_date, :expiry_date

    add_column :events, :description, :text
    add_column :billings, :stripe_customer_id, :string
  end
end
