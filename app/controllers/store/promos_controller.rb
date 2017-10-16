class Store::PromosController < Store::StoreController
  def index
    @promos = Promo.includes(:preview).all.where.not(preview: nil).order(created_at: :desc)
  end

  def show
    @promo = Promo.find(params[:id])
  end
end