class Product < ApplicationRecord
  belongs_to :metal_color, optional: true
  belongs_to :product_type, optional: true
  belongs_to :category
  belongs_to :sale_size, optional: true
  belongs_to :collection, optional: true
  belongs_to :kit, optional: true, counter_cache: true
  belongs_to :manufacturer, optional: true
  has_and_belongs_to_many :metal_types
  has_and_belongs_to_many :sizes

  #связан полиморфной связью с картинками. Связанные картинки удаляются при удалении товара.
  #TODO Удаляются именно объекты класса Picture. Необходимо явно удалять сами файлы изображений
  has_many :pictures, as: :imageable, dependent: :destroy
  belongs_to :preview, class_name: 'Picture', optional: true

  enum sex: {female: 0, male: 1, unisex: 2, genderless: 3}

  validates :priority,numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
