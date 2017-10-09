class Admin::ProductsLightController < Admin::AdminController
  def index
    @products = Product.order(updated_at: :desc)
    #TODO Сделать загрузку данных для главной страницы
  end
end