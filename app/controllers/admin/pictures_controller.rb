class Admin::PicturesController < Admin::AdminController
  def new
    @picture = Picture.new
  end
  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.json { render json: { id: @picture.id, url: @picture.image(:thumb)} }
      end
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
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Товар был успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:image)
  end
end