class Store::CategoriesController < Store::StoreController
  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end
end