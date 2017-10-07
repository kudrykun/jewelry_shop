class Store::ManufacturersController < Store::StoreController
  def index
    @categories = Category.all.order(:priority)
    @brands = Manufacturer.all
  end
end