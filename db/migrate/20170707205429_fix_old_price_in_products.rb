class FixOldPriceInProducts < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :old_price, :new_price
  end
end
