class CreateSaleSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :sale_sizes do |t|
      t.numeric :sale_percent

      t.timestamps
    end
  end
end
