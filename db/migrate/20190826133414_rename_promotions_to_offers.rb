class RenamePromotionsToOffers < ActiveRecord::Migration[5.2]
  def change
    rename_table :promotions, :offers
  end
end
