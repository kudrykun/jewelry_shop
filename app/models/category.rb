class Category < ApplicationRecord
  has_and_belongs_to_many :product_types
  has_many :products
  #связан полиморфной связью с картинкой. Связанная картинка удаляется при удалении товара.
  #TODO Удаляются именно объекты класса Picture. Необходимо явно удалять сами файлы изображений
  has_one :picture, as: :imageable, dependent: :destroy

  validates :title, presence: true, length: {in: 1..50}
end
