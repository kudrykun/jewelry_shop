class Store::StoreController < ApplicationController
  layout 'store'
  before_action :set_nav_categories

  def set_nav_categories
    @categories = Category.all.order(:priority)
  end
end