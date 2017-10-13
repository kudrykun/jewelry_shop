class Store::ManufacturersController < Store::StoreController
  def index
    @brands = Manufacturer.includes(:index).all
  end
end