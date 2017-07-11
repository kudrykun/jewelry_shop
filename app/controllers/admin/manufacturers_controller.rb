class Admin::ManufacturersController < Admin::AdminController
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]

  def index
    @manufacturers = Manufacturer.all
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

    if @manufacturer.save
      redirect_to admin_manufacturer_path(@manufacturer), notice: 'Производитель был успешно добавлен.'
    else
      render :new
    end
  end

  def update
    if @manufacturer.update(manufacturer_params)
      redirect_to admin_manufacturer_path(@manufacturer), notice: 'Производитель был успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @manufacturer.destroy
    redirect_to admin_manufacturers_url, notice: 'Производитель был успешно удален.'
  end

  private
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end

    def manufacturer_params
      params.require(:manufacturer).permit(:title)
    end
end
