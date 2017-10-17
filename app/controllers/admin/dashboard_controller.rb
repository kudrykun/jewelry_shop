class Admin::DashboardController < Admin::AdminController
  def index
    @products = Product.all
    @collections = Collection.all
    @kits = Kit.all
  end
end
