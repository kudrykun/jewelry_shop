class AddPricePerGrammToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :price_per_gramm, :numeric
  end
end
