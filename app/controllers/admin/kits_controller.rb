class Admin::KitsController < Admin::AdminController
  before_action :set_kit, only: [:show, :edit, :update, :destroy]
  
  def index
    @kits = Kit.all
  end
  
  def show
  end
  
  def new
    @kit = Kit.new
  end
  
  def edit
  end
  
  def create
    @kit = Kit.new(kit_params)
    if @kit.save
      redirect_to admin_kit_path(@kit), notice: 'Набор был добавлен.'
    else
      render :new
    end
  end


  def update
    if @kit.update(kit_params)
      redirect_to admin_kit_path(@kit), notice: 'Набор был обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @kit.destroy
    redirect_to admin_kits_url, notice: 'Набор был удален.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kit
      @kit = Kit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kit_params
      params.require(:kit).permit(:title)
    end
end
