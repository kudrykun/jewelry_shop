class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  #загружает цвета металлов, типы продуктов, размеры скидок для создания и сохранения
  before_action :set_selecting_collections, only: [:new, :create, :edit, :update]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @picture = Picture.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_product_path(@product), notice: 'Товар был успешно создан.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_product_path(@product), notice: 'Товар был успешно обновлен.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Товар был успешно удален.' }
      format.json { head :no_content }
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
                                      :incrustation_ids => [],
                                      :metal_type_ids => [],
                                      :size_ids => [],
                                      :picture_ids => [])
    end
end
