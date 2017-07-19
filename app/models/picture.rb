class Picture < ApplicationRecord
=begin
  Модель для хранения изображения и информации о нем.
  Применяется как для использования в других сущностях(например в товарах), так и, например, в слайдерах.
=end
  belongs_to :imageable, polymorphic: true, optional: true
  has_one :product

  has_attached_file :image, styles: { medium: "400x400#", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end