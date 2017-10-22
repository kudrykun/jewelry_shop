class Admin::CollectionsController < Admin::AdminController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  before_action :set_selecting_products, only: [:new, :create, :edit, :update]

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.all
    @products = Product.all
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    @products = Product.includes(:manufacturer)
                    .includes(:sale_size)
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
                    .where(collection: @collection)
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        record_activity(@collection)
        format.html {redirect_to admin_collection_path(@collection), notice: 'Коллекция была успешно добавлена.'}
        format.json {render :show, status: :created, location: @collection}
      else
        format.html {render :new}
        format.json {render json: @collection.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        record_activity(@collection)
        format.html {redirect_to admin_collection_path(@collection), notice: 'Коллекция была успешно обновлена.'}
        format.json {render :show, status: :ok, location: @collection}
      else
        format.html {render :edit}
        format.json {render json: @collection.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.products.each do |product|
      product.collection = nil
      product.save
    end
    @collection_tmp = @collection.dup
    @collection.destroy
    record_activity(@collection_tmp)
    respond_to do |format|
      format.html {redirect_to admin_collections_url, notice: 'Коллекция была успешно удалена.'}
      format.json {head :no_content}
    end
  end

  private

  # используется в форме коллекции
  def set_selecting_products
    @products = Product.all.order(:title)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_collection
    @collection = Collection.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def collection_params
    params.require(:collection).permit(:title, :description, :priority, :product_ids => [])
  end
end
