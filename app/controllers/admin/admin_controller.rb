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
    @activity.user_name = "#{@activity.user.first_name} #{@activity.user.second_name}"
    @activity.controller_name = controller_name
    @activity.entity_name = case obj.class.model_name
                              when 'Category' #
                                'Категории'
                              when 'ChainType' #
                                'Виды плетений'
                              when 'Collection' #
                                'Коллекции'
                              when 'Incrustation' #
                                'Вставки'
                              when 'Kit' #
                                'Комплекты'
                              when 'Manufacturer' #
                                'Производители'
                              when 'MetalColor' #
                                'Цвета металлов'
                              when 'MetalType' #
                                'Типы металлов'
                              when 'Picture'
                                'Картинки'
                              when 'ProductType' #
                                'Виды изделий'
                              when 'Product' #
                                'Изделия'
                              when 'Promo' #
                                'Акции'
                              when 'SaleSize' #
                                'Скидки'
                              when 'Shop' #
                                'Магазины'
                              when 'Size' #
                                'Размеры'
                              when 'Slide' #
                                'Слайды'
                              when 'User'
                                'Пользователи'
                              else
                                obj.class.model_name
                            end
    @activity.action = case action_name
               when 'create'
                 'Создал'
               when 'update'
                 'Обновил'
               when 'destroy'
                 'Удалил'
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
                      'изделие'
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
                               when 'Product'
                                 ' "' + obj.artikul + '"'
                               when 'Slide'
                                 ''
                               when 'User'
                                 ' "' + obj.first_name + ' ' + obj.second_name + '"'
                               else
                                 ' "' + obj.title + '"'
                             end
    @activity.note = @activity.action + ' ' + entity_name + @activity.object_title

    @activity.save
  end
end