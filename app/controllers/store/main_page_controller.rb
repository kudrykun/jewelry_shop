class Store::MainPageController < Store::StoreController
  layout 'main_page'

  def index
    # Бренды для слайдера брендов
    @brands = Manufacturer.all
    @slides = Slide.all.where(hide: false).order(priority: :desc)
    @category = Category.all
    #TODO передавать в слайды только те объекты, кто есть картинки!
    # Продукты на главную страницу с пометкой hit
    @products_hit = Product.where(visible: true).where(hit: true).order(priority: :desc).order(updated_at: :desc)

    # Продукты на главную страницу со скидкой 40%
    @products40 = SaleSize.all.find_by(sale_percent: 40).products.where(visible: true).where(to_main_page: true).order(priority: :desc).order(updated_at: :desc)

    # Продукты на главную страницу со скидкой 50%
    @products50 = SaleSize.all.find_by(sale_percent: 50).products.where(visible: true).where(to_main_page: true).order(priority: :desc).order(updated_at: :desc)
  end
end