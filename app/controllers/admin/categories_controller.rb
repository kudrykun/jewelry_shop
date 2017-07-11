class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @product = Product.where(category: @category) #возможно что то не так
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_category_path(@category), notice: 'Категория была успешно создана.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: 'Категория была успешно обновлена.'
      render :show, status: :ok, location: @category
    else
      render :edit
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    redirect_to admin_categories_url, notice: 'Категория была успешно удалена.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title, :priority)
    end
end
