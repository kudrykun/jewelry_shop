class CreateProductsPromos < ActiveRecord::Migration[5.0]
  def change
    create_table :products_promos do |t|
      t.references :product, foreign_key: true
      t.references :promo, foreign_key: true
    end
  end
end
