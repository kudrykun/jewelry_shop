class Store::ManufacturersController < Store::StoreController
  def index
    @brands = Manufacturer.all
  end
end