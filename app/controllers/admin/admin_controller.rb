class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :set_nav_categories

  def set_nav_categories
    @categories = Category.all.order(:priority)
  end
end