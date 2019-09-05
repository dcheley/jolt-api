class RenamePromotions < ActiveRecord::Migration[5.2]
  def change
    rename_table :promotions, :advertisements
  end
end
