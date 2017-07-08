class Admin::MetalTypesController < Admin::AdminController
  before_action :set_metal_type, only: [:show, :edit, :update, :destroy]

  # GET /metal_types
  # GET /metal_types.json
  def index
    @metal_types = MetalType.all
  end

  # GET /metal_types/1
  # GET /metal_types/1.json
  def show
  end

  # GET /metal_types/new
  def new
    @metal_type = MetalType.new
  end

  # GET /metal_types/1/edit
  def edit
  end

  # POST /metal_types
  # POST /metal_types.json
  def create
    @metal_type = MetalType.new(metal_type_params)

    respond_to do |format|
      if @metal_type.save
        format.html { redirect_to admin_metal_type_path(@metal_type), notice: 'Данный вид материала был успешно создан.' }
        format.json { render :show, status: :created, location: @metal_type }
      else
        format.html { render :new }
        format.json { render json: @metal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metal_types/1
  # PATCH/PUT /metal_types/1.json
  def update
    respond_to do |format|
      if @metal_type.update(metal_type_params)
        format.html { redirect_to admin_metal_type_path(@metal_type), notice: 'Данный вид материала был успешно обновлен.' }
        format.json { render :show, status: :ok, location: @metal_type }
      else
        format.html { render :edit }
        format.json { render json: @metal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metal_types/1
  # DELETE /metal_types/1.json
  def destroy
    @metal_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_metal_types_url, notice: 'Данный вид материала был успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metal_type
      @metal_type = MetalType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metal_type_params
      params.require(:metal_type).permit(:title)
    end
end
