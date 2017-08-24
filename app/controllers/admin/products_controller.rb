class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  #загружает цвета металлов, типы продуктов, размеры скидок для создания и сохранения
  before_action :set_selecting_collections, only: [:new, :create, :edit, :update]

  def index
    @products = Product.all
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
        if params[:picture_ids]
          params[:picture_ids].each { |picture_id| @product.pictures << Picture.find(picture_id)}
        end
        format.html {redirect_to admin_product_path(@product), notice: 'Товар был успешно создан.'}
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
        if params[:picture_ids]
          params[:picture_ids].each { |picture_id| @product.pictures << Picture.find(picture_id)}
        end
        format.html {redirect_to admin_product_path(@product), notice: 'Товар был успешно обновлен.'}
        format.json {render :show, status: :ok, location: @product}
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
                                    :picture_ids => [])
  end
end
