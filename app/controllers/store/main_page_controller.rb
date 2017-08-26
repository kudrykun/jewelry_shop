class Store::MainPageController < Store::StoreController
  def index
    @products_hit = Product.where(visible: true).where(hit: true).order(priority: :desc).order(updated_at: :desc)
    @products15 = Product.where(visible: true).where(to_main_page: true).order(priority: :desc).order(updated_at: :desc)
    #TODO Сделать загрузку данных для главной страницы
  end
end