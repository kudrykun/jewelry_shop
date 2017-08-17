class Admin::ProductTypesController < Admin::AdminController
  before_action :set_product_type, only: [:show, :edit, :update, :destroy]
  before_action :set_selecting_collections, only: [:new, :create, :edit, :update]

  # GET /product_types
  # GET /product_types.json
  def index
    @product_types = ProductType.all
  end

  # GET /product_types/1
  # GET /product_types/1.json
  def show
  end

  # GET /product_types/new
  def new
    @product_type = ProductType.new
  end

  # GET /product_types/1/edit
  def edit
  end

  # POST /product_types
  # POST /product_types.json
  def create
    @product_type = ProductType.new(product_type_params)

    respond_to do |format|
      if @product_type.save
        format.html { redirect_to admin_product_type_path(@product_type), notice: 'Вид изделия был успешной создан.' }
        format.json { render :show, status: :created, location: @product_type }
      else
        format.html { render :new }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_types/1
  # PATCH/PUT /product_types/1.json
  def update
    respond_to do |format|
      if @product_type.update(product_type_params)
        format.html { redirect_to admin_product_type_path(@product_type), notice: 'Вид изделия был успешно обновлен.' }
        format.json { render :show, status: :ok, location: @product_type }
      else
        format.html { render :edit }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_types/1
  # DELETE /product_types/1.json
  def destroy
    @product_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_product_types_url, notice: 'Вид изделия был успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_selecting_collections
      @categories = Category.all.order(:updated_at).order(:priority)
    end
    def set_product_type
      @product_type = ProductType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_type_params
      params.require(:product_type).permit(:title,
                                           :category_id)
    end
end
