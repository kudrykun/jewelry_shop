class RemoveOldSizeFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :old_size, :decimal
  end
end
