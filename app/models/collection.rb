class Collection < ApplicationRecord
  has_many :products
  #связан полиморфной связью с картинкой. Связанная картинка удаляется при удалении товара.
  #TODO Удаляются именно объекты класса Picture. Необходимо явно удалять сами файлы изображений
  has_one :picture, as: :imageable, dependent: :destroy

  validates :title, presence: true
  validates :title, length: {in: 1..50}
  validates :description, length: {maximum: 500}
end
