class Store::MainPageController < Store::StoreController
  layout 'main_page'

  def index
    # Бренды для слайдера брендов
    @brands = Manufacturer.all.where.not(slide: nil)
    slides = Slide.all.where(hide: false).order(priority: :desc)
    @slides = []
    slides.each do |slide|
      if !slide.picture.nil?
        @slides << slide
      end
    end

    main_page_blocks = MainPageBlock.all.where(hide: false).order(priority: :desc)
    @main_page_blocks = []
    main_page_blocks.each do |main_page_block|
      if !main_page_block.picture.nil?
        @main_page_blocks << main_page_block
      end
    end

    @category = Category.all
    #TODO передавать в слайды только те объекты, кто есть картинки!
    # Продукты на главную страницу с пометкой hit
    products_hit = Product.where(visible: true).where(hit: true).order(priority: :desc).order(updated_at: :desc)
    @products_hit = []
    products_hit.each do |product|
      if !product.preview.nil?
        @products_hit << product
      end
    end
    # Продукты на главную страницу со скидкой 40%
    sale40 = SaleSize.find_by(sale_percent: 40)
    @products40 = []
    if !sale40.nil?
      products40 = sale40.products.where(visible: true).where(to_main_page: true).order(priority: :desc).order(updated_at: :desc)
      products40.each do |product|
        if !product.preview.nil?
          @products40 << product
        end
      end
    else
      @products40
    end

    # Продукты на главную страницу со скидкой 50%
    sale50 = SaleSize.all.find_by(sale_percent: 50)
    @products50 = []
    if !sale50.nil?
      products50 = sale50.products.where(visible: true).where(to_main_page: true).order(priority: :desc).order(updated_at: :desc)
      products50.each do |product|
        if !product.preview.nil?
          @products50 << product
        end
      end
    else
      @products50
    end
  end
end