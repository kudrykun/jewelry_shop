class AddKitToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :kit, foreign_key: true
  end
end
