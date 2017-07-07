class KitsController < ApplicationController
  before_action :set_kit, only: [:show, :edit, :update, :destroy]
  
  def index
    @kits = Kit.all
  end
  
  def show
  end
  
  def new
    @kit = Kit.new
  end
  
  def edit
  end
  
  def create
    @kit = Kit.new(kit_params)
    if @kit.save
      redirect_to @kit, notice: 'Kit was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /kits/1
  # PATCH/PUT /kits/1.json
  def update
    if @kit.update(kit_params)
      redirect_to @kit, notice: 'Kit was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kits/1
  # DELETE /kits/1.json
  def destroy
    @kit.destroy
    redirect_to kits_url, notice: 'Kit was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kit
      @kit = Kit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kit_params
      params.require(:kit).permit(:title)
    end
end
