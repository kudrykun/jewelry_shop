class AddChainTypeToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :chain_type, foreign_key: true
  end
end
