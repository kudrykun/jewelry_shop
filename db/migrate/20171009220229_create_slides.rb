class CreateSlides < ActiveRecord::Migration[5.0]
  def change
    create_table :slides do |t|
      t.boolean :hide, default: false
      t.string :href
      t.integer :priority
    end
  end
end
