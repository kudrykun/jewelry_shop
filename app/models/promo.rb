class Promo < ApplicationRecord
  # изображение превью
  belongs_to :preview, class_name: 'Picture', optional: true
  # изображение для текста акции
  belongs_to :picture, class_name: 'Picture', optional: true

  has_many :products, through: :product_promos
end
