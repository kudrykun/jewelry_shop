class Admin::ActivityLogsController < Admin::AdminController
  def index
    @logs = ActivityLog.limit(50)
  end
end