class Shop < ApplicationRecord
  has_many :size_items
  has_many :products, -> { distinct }, :through => :size_items
end
