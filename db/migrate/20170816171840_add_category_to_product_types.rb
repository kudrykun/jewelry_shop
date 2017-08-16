class AddCategoryToProductTypes < ActiveRecord::Migration[5.0]
  def change
    add_reference :product_types, :category, foreign_key: true
  end
end
