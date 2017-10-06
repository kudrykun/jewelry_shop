class Manufacturer < ApplicationRecord
  has_many :products
  # изображение для списка производителей
  belongs_to :index, class_name: 'Picture', optional: true
  # изображение для слайдшоу брендов на главной
  belongs_to :slide, class_name: 'Picture', optional: true

  validates :title, presence: true, length: {in: 1..50}

  # значения для фильтра по вставкам
  def self.options_for_manufacturer_select
    order('LOWER(title)').map { |e| [e.title, e.id] }
  end
end
