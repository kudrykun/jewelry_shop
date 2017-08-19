class Store::ProductController < Store::StoreController
  before_action :set_product, only: [:show]
  def index
    @products = Product.all
    #TODO Сделать загрузку данных для главной страницы
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:title, :description, :image_url, :price, :category_id )
  end
end