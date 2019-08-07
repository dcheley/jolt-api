class AddMerchantColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :description, :text
    add_column :merchants, :address, :string
    add_column :merchants, :postal_code, :string
    add_column :merchants, :phone, :string
    add_column :merchants, :category, :string
  end
end
