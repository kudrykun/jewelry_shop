class Admin::PicturesController < Admin::AdminController
  def new
    @picture = Picture.new
  end
  def create
    @picture = Picture.new(picture_params)
      if @picture.save
        render json: { message: "success", id: @picture.id, url: @picture.image(:thumb)}, :status => 200
      else
        render json: @picture.errors, :status => 400
      end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(picture_params)
        format.html { redirect_to admin_product_path(@product), notice: 'Товар был успешно обновлен.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @picture = Picture.find(params[:id])
    if @picture.destroy
      render json: {message: 'Файл удален с сервера'}
    else
      render json: @picture.errors
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:image)
  end
end