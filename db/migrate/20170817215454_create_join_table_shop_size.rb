class CreateJoinTableShopSize < ActiveRecord::Migration[5.0]
  def change
    create_join_table :shops, :sizes do |t|
      t.index [:shop_id, :size_id]
      t.index [:size_id, :shop_id]
    end
  end
end
