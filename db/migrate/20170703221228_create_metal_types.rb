class CreateMetalTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :metal_types do |t|
      t.string :title

      t.timestamps
    end
  end
end
