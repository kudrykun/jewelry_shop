class Admin::DashboardController < Admin::AdminController
  def index
    @products = Product.all
    @collections = Collection.all
    @kits = Kit.all
    @users = []
    if current_user.admin?
      @users = User.includes(:activity_logs).all.order(created_at: :desc)
    else
      @users = User.includes(:activity_logs).all.where(admin: false).order(created_at: :desc)
    end
  end
end
