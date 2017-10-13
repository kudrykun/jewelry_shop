class Store::CatalogController < Store::StoreController
  layout 'catalog'
  def index
    @category = Category.includes(:preview).all.order(preview_priority: :asc)
  end
end