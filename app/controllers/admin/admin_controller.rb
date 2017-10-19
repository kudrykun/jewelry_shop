class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :set_nav_categories
  before_action :authenticate_user!

  def set_nav_categories
    @categories = Category.all.order(:priority)
  end

  def record_activity(obj)
    @activity = ActivityLog.new
    @activity.user = current_user
    @activity.user_ip = current_user.current_sign_in_ip
    @activity.controller = controller_name
    @activity.action = action_name
    @activity.user_name = ''
    @activity.entity_name = ''
    name = "#{@activity.user.first_name} #{@activity.user.second_name}"
    action = case @activity.action
               when 'create'
                 'создал'
               when 'update'
                 'обновил'
               when 'destroy'
                 'удалил'
               else
                 @activity.action
             end

    entity = case obj.class.model_name
               when 'Category'
                 'категорию'
               when 'Collection'
                 'коллекцию'
               when 'Incrustation'
                 'вставку'
               when 'Kit'
                 'комплект'
               when 'Kit'
                 'производителя'
               when 'MetalColor'
                 'цвет металла'
               when 'MetalType'
                 'металл'
               when 'Picture'
                 'картинку'
               when 'ProductType'
                 'тип продукта'
               when 'Product'
                 'продукт'
               when 'Promo'
                 'акцию'
               when 'SaleSize'
                 'скидку'
               when 'Shop'
                 'магазин'
               when 'Size'
                 'размер'
               when 'Slide'
                 'слайд'
               when 'Slide'
                 'пользователя'
               else
                 @activity.controller
             end
    @activity.note = name + ' ' + action + ' ' + entity + ' ' + obj.title

    @activity.save
  end
end