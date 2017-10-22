class Admin::PromosController < Admin::AdminController
  before_action :set_promo, only: [:show, :edit, :update, :destroy]

  def index
    @promos = Promo.all
  end

  def show
  end

  def new
    @promo = Promo.new
  end

  def edit
  end

  def create
    @promo = Promo.new(promo_params)
    if params[:preview]
      preview = Picture.create(image: params[:preview])
      @promo.preview = preview
    end
    if params[:picture]
      picture = Picture.create(image: params[:picture])
      @promo.picture = picture
    end
    respond_to do |format|
      if @promo.save
        record_activity(@promo)
        format.html {redirect_to edit_admin_promo_path(@promo), notice: 'Акция была успешно создана.'}
        format.json {render :show, status: :created, location: @promo}
      else
        format.html {render :new}
        format.json {render json: @promo.errors, status: :unprocessable_entity}
      end
    end
  end

  def update

    if params[:preview]
      preview = Picture.create(image: params[:preview])
      @promo.preview = preview
    end
    if params[:picture]
      picture = Picture.create(image: params[:picture])
      @promo.picture = picture
    end

    respond_to do |format|
      if @promo.update(promo_params)
        record_activity(@promo)
        format.html {redirect_to edit_admin_promo_path(@promo), notice: 'Акция была успешно обновлена.'}
        format.json {render :nothing => true}
      else
        format.html {render :edit}
        format.json {render json: @promo.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    if !@promo.preview.nil?
      @promo.preview.destroy
    end
    if !@promo.picture.nil?
      @promo.picture.destroy
    end
    @promo_tmp = @promo.dup
    @promo.destroy
    record_activity(@promo_tmp)
    respond_to do |format|
      format.html {redirect_to admin_promos_url, notice: 'Акция была успешно удалена.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_promo
    @promo = Promo.find(params[:id])
  end

  def promo_params
    params.require(:promo).permit(:title, :text)
  end
end
