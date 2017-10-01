class Store::CatalogController < Store::StoreController
  layout 'catalog'
  def index
    @categories = Category.all.order(:priority)
  end
end