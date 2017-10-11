class Admin::ProductsLightController < Admin::AdminController
  def index
    @products = Product.includes(:manufacturer)
                    .includes(:sale_size)
                    .includes(:shops)
                    .includes(:sizes)
                    .includes(:category)
                    .includes(:product_type)
                    .includes(:kit)
                    .includes(:collection)
                    .includes(:pictures)
                    .all.order(updated_at: :desc)
    #TODO Сделать загрузку данных для главной страницы
  end
end