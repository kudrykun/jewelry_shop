class ResolveErrorInCategoriesProductTypes < ActiveRecord::Migration[5.0]
  def change
    remove_reference :categories_product_types, :categories, index: true
    remove_reference :categories_product_types, :product_types, index: true
  end
end
