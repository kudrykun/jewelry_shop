class Admin::MainPageBlocksController < Admin::AdminController
  before_action :set_main_page_block, only: [:show, :edit, :update, :destroy]

  def index
    @main_page_blocks = MainPageBlock.all
  end

  def show
  end

  def new
    @main_page_block = MainPageBlock.new
  end

  def edit
  end

  def create
    @main_page_block = MainPageBlock.new(main_page_block_params)
    if params[:picture]
      picture = Picture.create(image: params[:picture])
      @main_page_block.picture = picture
    end
    respond_to do |format|
      if @main_page_block.save
        record_activity(@main_page_block)
        format.html {redirect_to edit_admin_main_page_block_path(@main_page_block), notice: 'Блок был успешно создан.'}
        format.json {render :show, status: :created, location: @main_page_block}
      else
        format.html {render :new}
        format.json {render json: @main_page_block.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    if params[:picture]
      picture = Picture.create(image: params[:picture])
      @main_page_block.picture = picture
    end

    respond_to do |format|
      if @main_page_block.update(main_page_block_params)
        record_activity(@main_page_block)
        format.html {redirect_to edit_admin_main_page_block_path(@main_page_block), notice: 'Блок был успешно обновлен.'}
        format.json {render :nothing => true}
      else
        format.html {render :edit}
        format.json {render json: @main_page_block.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    if !@main_page_block.picture.nil?
      @main_page_block.picture.destroy
    end
    @main_page_block_tmp = @main_page_block.dup
    @main_page_block.destroy
    record_activity(@main_page_block_tmp)
    respond_to do |format|
      format.html {redirect_to admin_main_page_blocks_url, notice: 'Блок был успешно удален.'}
      format.json {head :no_content}
    end
  end
  private

  def set_main_page_block
    @main_page_block = MainPageBlock.find(params[:id])
  end

  def main_page_block_params
    params.require(:main_page_block).permit(:title, :href, :hide, :picture_id, :priority, :class_s, :class_sm)
  end

end
