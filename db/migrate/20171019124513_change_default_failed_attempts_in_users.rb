class ChangeDefaultFailedAttemptsInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:users, :failed_attempts, 0)
  end
end
