class AddCountOfProductsToKits < ActiveRecord::Migration[5.0]
  def change
    add_column :kits, :products_count, :integer
  endgit
end
