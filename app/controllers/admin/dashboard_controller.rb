class Admin::DashboardController < Admin::AdminController
  def index
    @products = Product.all
    @collections = Collection.all
    @kits = Kit.all
    @logs = []
    if current_user.admin?
      @logs = ActivityLog.all
    end

  end
end
