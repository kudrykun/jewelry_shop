class AddPreviewClassToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :preview_class, :string, default: ''
  end
end
