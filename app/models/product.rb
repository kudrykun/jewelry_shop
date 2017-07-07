class Product < ApplicationRecord
  belongs_to :metal_color, optional: true
  belongs_to :product_type, optional: true
  belongs_to :category, optional: true
  belongs_to :sale_size, optional: true
  belongs_to :collection, optional: true
  belongs_to :kit, optional: true
  has_and_belongs_to_many :metal_types
  has_and_belongs_to_many :incrustations
  has_and_belongs_to_many :size

  #связан полиморфной связью с картинками. Связанные картинки удаляются при удалении товара.
  #TODO Удаляются именно объекты класса Picture. Необходимо явно удалять сами файлы изображений
  has_many :pictures, as: :imageable, dependent: :destroy
end
