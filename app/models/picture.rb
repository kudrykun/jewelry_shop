class Picture < ApplicationRecord
=begin
  Модель для хранения изображения и информации о нем.
  Применяется как для использования в других сущностях(например в товарах), так и, например, в слайдерах.
=end
  belongs_to :imageable, polymorphic: true, optional: true
  has_one :product_preview, foreign_key: "preview_id", class_name: 'Product'

  has_attached_file :image, styles: { large: "615x615#", medium: "280x280#", thumb: "150x150#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment :image,size: { in: 0..3.megabytes }
end