class Admin::ProductsLightController < Admin::AdminController
  def index
    @products = Product.where(visible: true)
    #TODO Сделать загрузку данных для главной страницы
  end
end