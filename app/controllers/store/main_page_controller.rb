class Store::MainPageController < Store::StoreController
  def index
    @products = Product.all
    #TODO Сделать загрузку данных для главной страницы
  end
end