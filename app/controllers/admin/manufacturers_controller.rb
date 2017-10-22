class Admin::ManufacturersController < Admin::AdminController
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]

  def index
    @manufacturers = Manufacturer.includes(:index).includes(:slide).all
  end


  def show
  end


  def new
    @manufacturer = Manufacturer.new
  end

  def edit
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if params[:index]
        index = Picture.create(image: params[:index])
        @manufacturer.index = index
    end
    if params[:slide]
      slide = Picture.create(image: params[:slide])
      @manufacturer.slide = slide
    end

    if @manufacturer.save
      record_activity(@manufacturer)
      redirect_to edit_admin_manufacturer_path(@manufacturer), notice: 'Производитель был успешно добавлен.'
    else
      render :new
    end
  end

  def update
    if params[:index]
      index = Picture.create(image: params[:index])
      @manufacturer.index = index
    end
    if params[:slide]
      slide = Picture.create(image: params[:slide])
      @manufacturer.slide = slide
    end
    if @manufacturer.update(manufacturer_params)
      record_activity(@manufacturer)
      redirect_to edit_admin_manufacturer_path(@manufacturer), notice: 'Производитель был успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    if !@manufacturer.index.nil?
      @manufacturer.index.destroy
    end
    if !@manufacturer.slide.nil?
      @manufacturer.slide.destroy
    end
    @manufacturer.products.each do |product|
      product.manufacturer = nil
      product.save
    end
    @manufacturer_tmp = @manufacturer.dup
    @manufacturer.destroy
    record_activity(@manufacturer_tmp)
    redirect_to admin_manufacturers_url, notice: 'Производитель был успешно удален.'
  end

  private
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end

    def manufacturer_params
      params.require(:manufacturer).permit(:title, :description)
    end
end
