class AddPolymorphicToActivityLog < ActiveRecord::Migration[5.0]
  def change
    add_reference :activity_logs, :loggable, polymorphic: true, index: true
  end
end
