class AddPriorityToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :priority, :integer
  end
end
