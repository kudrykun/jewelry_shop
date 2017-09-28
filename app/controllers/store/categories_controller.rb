class Store::CategoriesController < Store::StoreController
  def show
    @category = Category.find(params[:id])
    @filterrific = initialize_filterrific(
                       Product,
                       params[:filterrific],
                       select_options: {
                           sorted_by: Product.options_for_sorted_by
                       }
    ) or return

    # Respond to html for initial page load and to js for AJAX filter updates.
    @products = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end



      # Recover from invalid param sets, e.g., when a filter refers to the
      # database id of a record that doesn’t exist any more.
      # In this case we reset filterrific and discard all filter params.
  end
end