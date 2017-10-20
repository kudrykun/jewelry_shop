class Admin::IncrustationsController < Admin::AdminController
  before_action :set_incrustation, only: [:show, :edit, :update, :destroy]

  # GET /incrustations
  # GET /incrustations.json
  def index
    @incrustations = Incrustation.all
  end

  # GET /incrustations/1
  # GET /incrustations/1.json
  def show
  end

  # GET /incrustations/new
  def new
    @incrustation = Incrustation.new
  end

  # GET /incrustations/1/edit
  def edit
  end

  # POST /incrustations
  # POST /incrustations.json
  def create
    @incrustation = Incrustation.new(incrustation_params)

    respond_to do |format|
      if @incrustation.save
        record_activity(@incrustation)
        format.html { redirect_to admin_incrustations_path, notice: 'Вставка была успешно создана.' }
        format.json { render :show, status: :created, location: @incrustation }
      else
        format.html { render :new }
        format.json { render json: @incrustation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incrustations/1
  # PATCH/PUT /incrustations/1.json
  def update
    respond_to do |format|
      if @incrustation.update(incrustation_params)
        record_activity(@incrustation)
        format.html { redirect_to admin_incrustations_path, notice: 'Вставка была успешно обновлена.' }
        format.json { render :show, status: :ok, location: @incrustation }
      else
        format.html { render :edit }
        format.json { render json: @incrustation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incrustations/1
  # DELETE /incrustations/1.json
  def destroy
    @incrustation_tmp = @incrustation.dup
    @incrustation.destroy
    record_activity(@incrustation_tmp)
    respond_to do |format|
      format.html { redirect_to admin_incrustations_url, notice: 'Вставка была успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incrustation
      @incrustation = Incrustation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incrustation_params
      params.require(:incrustation).permit(:title)
    end
end
