class Admin::DashboardController < Admin::AdminController
  def index
    @products = Product.all
    @categories = Category.all
    @collections = Collection.all
    @kits = Kit.all
  end
end
