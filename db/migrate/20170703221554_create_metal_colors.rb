class CreateMetalColors < ActiveRecord::Migration[5.0]
  def change
    create_table :metal_colors do |t|
      t.string :title

      t.timestamps
    end
  end
end
