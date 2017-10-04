class MetalType < ApplicationRecord
  has_many :metal_type_products
  has_many :products, through: :metal_type_products

  # опции для фильтра по металлу
  def self.options_for_metal_type_select
    order('LOWER(title)').map { |e| [e.title, e.id] }
  end
end
