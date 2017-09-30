class Manufacturer < ApplicationRecord
  has_many :products
  validates :title, presence: true, length: {in: 1..50}

  # значения для фильтра по вставкам
  def self.options_for_manufacturer_select
    order('LOWER(title)').map { |e| [e.title, e.id] }
  end
end
