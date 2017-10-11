class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  #загружает цвета металлов, типы продуктов, размеры скидок для создания и сохранения
  before_action :set_selecting_collections, only: [:new, :create, :edit, :update]

  before_action :set_action_info, only: [:new,:edit]

  def index
    @products = Product.includes(:manufacturer)
                    .includes(:sale_size)
                    .includes(:shops)
                    .includes(:sizes)
                    .includes(:category)
                    .includes(:product_type)
                    .includes(:kit)
                    .includes(:collection)
                    .includes(:metal_types)
                    .includes(:metal_color)
                    .includes(:incrustations)
                    .includes(:pictures)
                    .all.order(updated_at: :desc)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html {redirect_to edit_admin_product_path(@product), notice: 'Товар был успешно создан. Теперь вы можете добавить изображения.'}
        format.json {render :show, status: :created, location: @product}
      else
        format.html {render :new}
        format.json {render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        if params[:product][:picture_id]
          @product.pictures << Picture.find(params[:product][:picture_id])
        end
        format.html {redirect_to edit_admin_product_path(@product), notice: 'Товар был успешно обновлен.'}
        format.json {render :nothing => true}
=begin
        format.json {render :show, status: :ok, location: @product}
=end
      else
        format.html {render :edit}
        format.json {render json: @product.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @product.pictures.destroy_all
    if !@product.preview.nil?
      @product.preview.destroy
    end
    @product.incrustation_items.each {|item| item.delete}
    Shop.all.each do |shop|
      @product.size_items.where(shop: shop).each do |item|
        item.delete
      end
    end
    @product.destroy
    respond_to do |format|
      format.html {redirect_to admin_products_url, notice: 'Товар был успешно удален.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  def set_selecting_collections
    @categories = Category.all.order(:updated_at).order(:priority)
    @collections = Collection.all.order(:updated_at).order(:priority)
    @kits = Kit.all
    @incrustations = Incrustation.all.order(:title)
    @metal_types = MetalType.all.order(:title)
    @sizes = Size.all.order(:size)
    @shops = Shop.all.order(:updated_at)
    @metal_colors = MetalColor.all
    @product_types = ProductType.all
    @sale_sizes = SaleSize.all.order(:sale_percent)
    @manufacturers = Manufacturer.all
    @chain_types = ChainType.all
    @promos = Promo.all
  end

  def set_action_info
    @from_products = false
    @from_category = false
    @from_collection = false
    @from_new = false
    @current_new = false
    # определяет, с отуда отправлен запрос на редактирование
    prev = Rails.application.routes.recognize_path(request.referrer)
    @prev = Rails.application.routes.recognize_path(request.referrer)
    if (prev[:controller] == 'admin/products') && (prev[:action] == 'index')
      @from_products = true
    end
    if (prev[:controller] == 'admin/categories') && (prev[:action] == 'show')
      @from_category = true
      @category = Category.find(prev[:id])
    end
    if (prev[:controller] == 'admin/collections') && (prev[:action] == 'show')
      @from_collection = true
      @collection = Collection.find(prev[:id])
    end
    if (prev[:controller] == 'admin/products') && (prev[:action] == 'new')
      @from_new = true
    end
    if (controller_name == 'products') && (action_name == 'new')
      @current_new = true
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:title,
                                    :artikul,
                                    :price,
                                    :weight,
                                    :sex,
                                    :metal_color_id,
                                    :product_type_id,
                                    :sale_size_id,
                                    :collection_id,
                                    :category_id,
                                    :kit_id,
                                    :chain_type_id,
                                    :new_price,
                                    :to_main_page,
                                    :manufacturer_id,
                                    :priority,
                                    :price_per_gramm,
                                    :preview_id,
                                    :visible,
                                    :recommendation,
                                    :hit,
                                    :incrustation_items_attributes => [:id,
                                                                       :quantity,
                                                                       :purity,
                                                                       :weight,
                                                                       :incrustation_id,
                                                                       :_destroy],
                                    :size_items_attributes => [:id,
                                                               :shop_id,
                                                               :size_id,
                                                               :_destroy],
                                    :metal_type_ids => [],
                                    :size_ids => [],
                                    :promo_ids => []
                                    )
  end
end
