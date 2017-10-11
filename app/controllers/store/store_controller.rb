class Store::StoreController < ApplicationController
  layout 'store'
  before_action :set_nav_categories

  def set_nav_categories
    @categories = Category.all.where(to_nav: true).order(:priority)
  end
end