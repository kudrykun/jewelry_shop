class Store::MainPageController < Store::StoreController
  layout 'main_page'

  def index
    # Бренды для слайдера брендов
    @brands = Manufacturer.all.where.not(slide: nil)
    @slides = Slide.all.where(hide: false).where.not(picture: nil).order(priority: :asc)
    @category = Category.all
    #TODO передавать в слайды только те объекты, кто есть картинки!
    # Продукты на главную страницу с пометкой hit
    @products_hit = Product.where(visible: true).where(hit: true).where.not(preview: nil).order(priority: :desc).order(updated_at: :desc)

    # Продукты на главную страницу со скидкой 40%
    sale40 = SaleSize.find_by(sale_percent: 40)
    @products40 = []
    if !sale40.nil?
      @products40 = sale40.products.where(visible: true).where(to_main_page: true).where.not(preview: nil).order(priority: :desc).order(updated_at: :desc)
    else
      @products40
    end

    # Продукты на главную страницу со скидкой 50%
    sale50 = SaleSize.all.find_by(sale_percent: 50)
    @products50 = []
    if !sale50.nil?
      @products50 = sale50.products.where(visible: true).where(to_main_page: true).where.not(preview: nil).order(priority: :desc).order(updated_at: :desc)
    else
      @products50
    end
  end
end