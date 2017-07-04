class Product < ApplicationRecord
  belongs_to :metal_color
  belongs_to :product_type
  belongs_to :sale_size
  has_and_belongs_to_many :metal_types
  has_and_belongs_to_many :incrustations
  has_and_belongs_to_many :size
end
