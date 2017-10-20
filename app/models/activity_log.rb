class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :loggable, polymorphic: true, optional: true
end
