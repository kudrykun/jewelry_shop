class Admin::KitsController < Admin::AdminController
  before_action :set_kit, only: [:show, :edit, :update, :destroy]
  before_action :set_selecting_products, only: [:new, :create, :edit, :update]

  def index
    @kits = Kit.all
    @products = Product.all
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
      redirect_to admin_kit_path(@kit), notice: 'Комплект был добавлен.'
    else
      render :new
    end
  end


  def update
    if @kit.update(kit_params)
      redirect_to admin_kit_path(@kit), notice: 'Комплект был обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @kit.destroy
    redirect_to admin_kits_url, notice: 'Комплект был удален.'
  end

  private

  # используется в форме набора
  def set_selecting_products
    @products = Product.all.order(:title)
  end

  def set_kit
    @kit = Kit.find(params[:id])
  end

  def kit_params
    params.require(:kit).permit(:title, :product_ids => [])
  end

end
