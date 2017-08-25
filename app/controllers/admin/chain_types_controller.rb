class Admin::ChainTypesController < Admin::AdminController

  before_action :set_chain_type, only: [:show, :edit, :update, :destroy]

  def index
    @chain_types = ChainType.all
  end

  def show
  end

  def new
    @chain_type = ChainType.new
  end

  def edit
  end

  def create
    @chain_type = ChainType.new(chain_type_params)

    if @chain_type.save
      redirect_to admin_chain_types_path, notice: 'Вид плетения был успешно создан.'
    else
      render :new
    end
  end

  def update
    if @chain_type.update(chain_type_params)
      redirect_to admin_chain_types_path, notice: 'Вид плетения был успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @chain_type.products.each do |product|
      product.chain_type = nil
      product.save
    end
    @chain_type.destroy
    redirect_to admin_chain_types_url, notice: 'Вид плетения был успешно удален.'
  end

  private
  def set_chain_type
    @chain_type = ChainType.find(params[:id])
  end

  def chain_type_params
    params.require(:chain_type).permit(:title)
  end
end
