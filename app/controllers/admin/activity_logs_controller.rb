class Admin::ActivityLogsController < Admin::AdminController
  def index
    @logs = ActivityLog.all
  end
end