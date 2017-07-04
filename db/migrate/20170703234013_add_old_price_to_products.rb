class AddOldPriceToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :old_price, :decimal
  end
end
