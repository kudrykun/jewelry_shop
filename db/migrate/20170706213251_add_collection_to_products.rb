class AddCollectionToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :collection, foreign_key: true
  end
end
