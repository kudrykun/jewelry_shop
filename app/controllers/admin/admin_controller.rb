class Admin::AdminController < ApplicationController
  layout 'admin'
  before_action :set_nav_categories
  before_action :authenticate_user!

  def set_nav_categories
    @categories = Category.all.order(:priority)
  end

  def record_activity(obj)
    @activity = ActivityLog.new
    if obj.id.nil?
      @activity.loggable = nil
    else
      @activity.loggable = obj
    end
    @activity.user = current_user
    @activity.user_ip = current_user.current_sign_in_ip
    @activity.action = action_name
    @activity.user_name = "#{@activity.user.first_name} #{@activity.user.second_name}"
    @activity.entity_name = obj.class.model_name
    action =  case action_name
               when 'create'
                 'создал'
               when 'update'
                 'обновил'
               when 'destroy'
                 'удалил'
               else
                 action_name
             end

    entity_name = case obj.class.model_name
      when 'Category' #
        'категорию'
      when 'ChainType' #
        'вид плетения'
      when 'Collection' #
        'коллекцию'
      when 'Incrustation' #
        'вставку'
      when 'Kit' #
        'комплект'
      when 'Manufacturer' #
        'производителя'
      when 'MetalColor' #
        'цвет металла'
      when 'MetalType' #
        'тип металла'
      when 'Picture'
        'картинку'
      when 'ProductType' #
        'вид изделия'
      when 'Product' #
        'продукт'
      when 'Promo' #
        'акцию'
      when 'SaleSize' #
        'скидку'
      when 'Shop' #
        'магазин'
      when 'Size' #
        'размер'
      when 'Slide' #
        'слайд'
      when 'User'
        'пользователя'
      else
        obj.class.model_name
    end
    @activity.object_title = case obj.class.model_name
      when 'Picture'
        ' "' + obj.id + '"'
      when 'SaleSize'
        ' "' + "#{obj.sale_percent}" + '"'
      when 'Size'
        ' "' + obj.size + '"'
      when 'Slide'
        ''
      when 'User'
        ' "' + obj.first_name + ' ' + obj.second_name + '"'
      else
        ' "' + obj.title + '"'
    end
    @activity.note = @activity.user_name + ' ' + action + ' ' + entity_name + @activity.object_title

    @activity.save
  end
end