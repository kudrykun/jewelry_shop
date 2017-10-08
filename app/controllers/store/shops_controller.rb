class Store::ShopsController < Store::StoreController
  def index
    # TODO Это конечно костыль, надо подгружать категории в store controller
    @categories = Category.all.order(:priority)
  end
end