class Admin::DashboardController < Admin::AdminController
  def index
    @products = Product.all
    @collections = Collection.all
    @kits = Kit.all
    @users = User.includes(:activity_logs).all
    @logs = ActivityLog.all.order(created_at: :asc)
  end
end
