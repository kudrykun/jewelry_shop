class RemoveControllerFromActivityLogs < ActiveRecord::Migration[5.0]
  def change
    remove_column :activity_logs, :controller, :string
  end
end
