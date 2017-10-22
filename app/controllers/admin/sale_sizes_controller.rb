class Admin::SaleSizesController < Admin::AdminController
  before_action :set_sale_size, only: [:show, :edit, :update, :destroy]

  # GET /sale_sizes
  # GET /sale_sizes.json
  def index
    @sale_sizes = SaleSize.all.order(:sale_percent)
  end

  # GET /sale_sizes/1
  # GET /sale_sizes/1.json
  def show
  end

  # GET /sale_sizes/new
  def new
    @sale_size = SaleSize.new
  end

  # GET /sale_sizes/1/edit
  def edit
  end

  # POST /sale_sizes
  # POST /sale_sizes.json
  def create
    @sale_size = SaleSize.new(sale_size_params)

    respond_to do |format|
      if @sale_size.save
        record_activity(@sale_size)
        format.html { redirect_to admin_sale_sizes_path, notice: 'Скидка была создана.' }
        format.json { render :show, status: :created, location: @sale_size }
      else
        format.html { render :new }
        format.json { render json: @sale_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sale_sizes/1
  # PATCH/PUT /sale_sizes/1.json
  def update
    respond_to do |format|
      if @sale_size.update(sale_size_params)
        record_activity(@sale_size)
        format.html { redirect_to admin_sale_sizes_path, notice: 'Скидка была обновлена.' }
        format.json { render :show, status: :ok, location: @sale_size }
      else
        format.html { render :edit }
        format.json { render json: @sale_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_sizes/1
  # DELETE /sale_sizes/1.json
  def destroy
    @sale_size.products.each do |product|
      product.sale_size = nil
      product.new_price = nil
      product.save
    end
    @sale_size_tmp = @sale_size.dup
    @sale_size.destroy
    record_activity(@sale_size_tmp)
    respond_to do |format|
      format.html { redirect_to admin_sale_sizes_url, notice: 'Скидка была удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale_size
      @sale_size = SaleSize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_size_params
      params.require(:sale_size).permit(:sale_percent)
    end
end
