class AddImageFieldToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :picture
  end
end
