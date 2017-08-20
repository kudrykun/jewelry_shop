class Admin::ShopsController < Admin::AdminController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  def index
    @shops = Shop.all
  end

  def show
  end

  def new
    @shop = Shop.new
  end

  def edit
  end

  def create
    @shop = Shop.new(shop_params)
    respond_to do |format|
      if @shop.save
        format.html {redirect_to admin_shop_path(@shop), notice: 'Товар был успешно создан.'}
        format.json {render :show, status: :created, location: @shop}
      else
        format.html {render :new}
        format.json {render json: @shop.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html {redirect_to admin_product_path(@shop), notice: 'Товар был успешно обновлен.'}
        format.json {render :show, status: :ok, location: @shop}
      else
        format.html {render :edit}
        format.json {render json: @shop.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @shop.destroy
    respond_to do |format|
      format.html {redirect_to admin_shops_url, notice: 'Товар был успешно удален.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_shop
    @shop = shop.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:title)
  end
end
