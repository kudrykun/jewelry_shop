class Store::PromosController < Store::StoreController
  def index
    @promos = Promo.includes(:preview).all.order(created_at: :desc)
  end

  def show
    @promo = Promo.find(params[:id])
  end
end