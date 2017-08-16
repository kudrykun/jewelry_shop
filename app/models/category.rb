class Category < ApplicationRecord
  has_many :product_types
  has_many :product_types
  has_many :products, :through => :product_types
  #связан полиморфной связью с картинкой. Связанная картинка удаляется при удалении товара.
  #TODO Удаляются именно объекты класса Picture. Необходимо явно удалять сами файлы изображений
  has_one :picture, as: :imageable, dependent: :destroy

  validates :title, presence: true, length: {in: 1..50}
  validates :priority,numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
