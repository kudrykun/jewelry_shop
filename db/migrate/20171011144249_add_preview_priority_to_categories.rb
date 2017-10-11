class AddPreviewPriorityToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :preview_priority, :integer
  end
end
