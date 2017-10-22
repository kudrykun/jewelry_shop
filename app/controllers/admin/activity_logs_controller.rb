class Admin::ActivityLogsController < Admin::AdminController
  def index
    @logs = ActivityLog.all.order(created_at: :desc)
  end
end