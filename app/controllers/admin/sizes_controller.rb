class Admin::SizesController < Admin::AdminController
  before_action :set_size, only: [:show, :edit, :update, :destroy]

  # GET /sizes
  # GET /sizes.json
  def index
    @sizes = Size.all
  end

  # GET /sizes/1
  # GET /sizes/1.json
  def show
  end

  # GET /sizes/new
  def new
    @size = Size.new
  end

  # GET /sizes/1/edit
  def edit
  end

  # POST /sizes
  # POST /sizes.json
  def create
    @size = Size.new(size_params)

    respond_to do |format|
      if @size.save
        format.html { redirect_to admin_size_path(@size), notice: 'Размер был добавлен.' }
        format.json { render :show, status: :created, location: @size }
      else
        format.html { render :new }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sizes/1
  # PATCH/PUT /sizes/1.json
  def update
    respond_to do |format|
      if @size.update(size_params)
        format.html { redirect_to admin_size_path(@size), notice: 'Размер был обновлен.' }
        format.json { render :show, status: :ok, location: @size }
      else
        format.html { render :edit }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sizes/1
  # DELETE /sizes/1.json
  def destroy
    @size.destroy
    respond_to do |format|
      format.html { redirect_to admin_sizes_url, notice: 'Размер был удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_size
      @size = Size.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def size_params
      params.require(:size).permit(:size)
    end
end
