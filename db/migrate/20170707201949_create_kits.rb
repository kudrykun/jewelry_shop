class CreateKits < ActiveRecord::Migration[5.0]
  def change
    create_table :kits do |t|
      t.string :title

      t.timestamps
    end
  end
end
