class Category < ApplicationRecord
  has_many :product_types
  has_many :products
  #связан полиморфной связью с картинкой. Связанная картинка удаляется при удалении товара.
  #TODO Удаляются именно объекты класса Picture. Необходимо явно удалять сами файлы изображений
  has_one :picture, as: :imageable, dependent: :destroy
  belongs_to :preview, class_name: 'Picture', optional: true
  # изображение для слайдшоу брендов на главной
  belongs_to :banner, class_name: 'Picture', optional: true

  validates :title, presence: true, length: {in: 1..50}
  validates :priority,numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
