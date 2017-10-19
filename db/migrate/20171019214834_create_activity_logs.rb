class CreateActivityLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_logs do |t|
      t.references :user, foreign_key: true
      t.string :note
      t.string :user_ip
      t.string :controller
      t.string :action
      t.datetime :created_at, null: false
    end
  end
end
