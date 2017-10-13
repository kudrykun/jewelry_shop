class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_selecting_products, only: [:new, :create, :edit, :update]

  def index
    @categories = Category.includes(:preview).includes(:banner).all
    @products = Product.all
  end

  def show
    @products = Product.includes(:manufacturer)
                    .includes(:sale_size)
                    .includes(:category)
                    .includes(:shops)
                    .includes(:sizes)
                    .includes(:category)
                    .includes(:product_type)
                    .includes(:kit)
                    .includes(:collection)
                    .includes(:metal_types)
                    .includes(:metal_color)
                    .includes(:incrustations)
                    .includes(:pictures)
                    .where(category: @category)

  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if params[:preview]
      preview = Picture.create(image: params[:preview])
      @category.preview = preview
    end
    if params[:banner]
      banner = Picture.create(image: params[:banner])
      @category.banner = banner
    end
    if @category.save
      redirect_to edit_admin_category_path(@category), notice: 'Категория была успешно создана.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    if params[:preview]
      preview = Picture.create(image: params[:preview])
      @category.preview = preview
    end
    if params[:banner]
      banner = Picture.create(image: params[:banner])
      @category.banner = banner
    end
    if @category.update(category_params)
      redirect_to edit_admin_category_path(@category), notice: 'Категория была успешно обновлена.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if !@category.preview.nil?
      @category.preview.destroy
    end
    if !@category.banner.nil?
      @category.banner.destroy
    end
    @category.destroy
    redirect_to admin_categories_url, notice: 'Категория была успешно удалена.'
  end

  private

  # используется в форме категории
  def set_selecting_products
    @products = Product.all.order(:title)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:title,
                                     :to_nav,
                                     :priority,
                                     :preview_priority,
                                     :preview_class,
                                     :product_ids => [])
  end
end
