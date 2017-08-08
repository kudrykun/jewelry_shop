class AddPreviewToProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :preview
  end
end
