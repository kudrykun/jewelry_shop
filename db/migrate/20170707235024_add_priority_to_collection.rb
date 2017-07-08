class AddPriorityToCollection < ActiveRecord::Migration[5.0]
  def change
    add_column :collections, :priority, :integer
  end
end
