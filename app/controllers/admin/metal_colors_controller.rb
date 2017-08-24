class Admin::MetalColorsController < Admin::AdminController
  before_action :set_metal_color, only: [:show, :edit, :update, :destroy]

  # GET /metal_colors
  # GET /metal_colors.json
  def index
    @metal_colors = MetalColor.all
  end

  # GET /metal_colors/1
  # GET /metal_colors/1.json
  def show
  end

  # GET /metal_colors/new
  def new
    @metal_color = MetalColor.new
  end

  # GET /metal_colors/1/edit
  def edit
  end

  # POST /metal_colors
  # POST /metal_colors.json
  def create
    @metal_color = MetalColor.new(metal_color_params)

    respond_to do |format|
      if @metal_color.save
        format.html { redirect_to admin_metal_color_path(@metal_color), notice: 'Цвет металла был успешно добавлен.' }
        format.json { render :show, status: :created, location: @metal_color }
      else
        format.html { render :new }
        format.json { render json: @metal_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metal_colors/1
  # PATCH/PUT /metal_colors/1.json
  def update
    respond_to do |format|
      if @metal_color.update(metal_color_params)
        format.html { redirect_to admin_metal_color_path(@metal_color), notice: 'Цвет металла был успешно обновлен.' }
        format.json { render :show, status: :ok, location: @metal_color }
      else
        format.html { render :edit }
        format.json { render json: @metal_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metal_colors/1
  # DELETE /metal_colors/1.json
  def destroy
    @metal_color.products.each do |product|
      product.metal_color = nil
      product.save
    end
    @metal_color.destroy
    respond_to do |format|
      format.html { redirect_to admin_metal_colors_url, notice: 'Цвет металла был успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metal_color
      @metal_color = MetalColor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metal_color_params
      params.require(:metal_color).permit(:title)
    end
end
