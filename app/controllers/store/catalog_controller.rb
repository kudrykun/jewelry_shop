class Store::CatalogController < Store::StoreController
  layout 'catalog'
  def index
    @category = Category.all.order(preview_priority: :asc)
  end
end