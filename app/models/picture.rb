class Picture < ApplicationRecord
=begin
  Модель для хранения изображения и информации о нем.
  Применяется как для использования в других сущностях(например в товарах), так и, например, в слайдерах.
=end
  belongs_to :imageable, polymorphic: true
end