class DropTableProductsShopsSizes < ActiveRecord::Migration[5.0]
  def change
    drop_table :products_shops_sizes do |t|
      t.references :product, foreign_key: true
      t.references :shop, foreign_key: true
      t.references :size, foreign_key: true
      t.timestamps
    end
  end
end
