class Admin::SlidesController < Admin::AdminController
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  def index
    @slides = Slide.all
  end

  def show
  end

  def new
    @slide = Slide.new
  end

  def edit
  end

  def create
    @slide = Slide.new(slide_params)
    if params[:picture]
      picture = Picture.create(image: params[:picture])
      @slide.picture = picture
    end
    respond_to do |format|
      if @slide.save
        format.html {redirect_to edit_admin_slide_path(@slide), notice: 'Акция была успешно создана.'}
        format.json {render :show, status: :created, location: @slide}
      else
        format.html {render :new}
        format.json {render json: @slide.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    if params[:picture]
      picture = Picture.create(image: params[:picture])
      @slide.picture = picture
    end

    respond_to do |format|
      if @slide.update(slide_params)

        format.html {redirect_to edit_admin_slide_path(@slide), notice: 'Акция была успешно обновлена.'}
        format.json {render :nothing => true}
      else
        format.html {render :edit}
        format.json {render json: @slide.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    if !@slide.picture.nil?
      @slide.picture.destroy
    end
    @slide.destroy
    respond_to do |format|
      format.html {redirect_to admin_slides_url, notice: 'Акция была успешно удалена.'}
      format.json {head :no_content}
    end
  end
  private

  def set_slide
    @slide = Slide.find(params[:id])
  end

  def slide_params
    params.require(:slide).permit(:href, :hide, :picture_id, :priority)
  end

end
