class Store::CategoriesController < Store::StoreController
  layout 'categories'
  def show
    @category = Category.find(params[:id])

    # Здесь начинает работать фильтр
    @filterrific = initialize_filterrific(
                       Product,
                       params[:filterrific],
                       select_options: {
                           sorted_by: Product.options_for_sorted_by,
                           with_all_metal_type_ids: MetalType.options_for_metal_type_select,
                           with_all_incrustation_ids: Incrustation.options_for_incrustation_select,
                           with_manufacturer_id: Manufacturer.options_for_manufacturer_select,
                           with_sale_size_id: SaleSize.options_for_sale_size_select,
                       },
                        persistence_id: false,
                        default_filter_params: {}
    ) or return

    # Respond to html for initial page load and to js for AJAX filter updates.
    @products = @filterrific.find.where(category: @category).page(params[:page]).per_page(12)
    respond_to do |format|
      format.html
      format.js
    end



      # Recover from invalid param sets, e.g., when a filter refers to the
      # database id of a record that doesn’t exist any more.
      # In this case we reset filterrific and discard all filter params.
  end
end