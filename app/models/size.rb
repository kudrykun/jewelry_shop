class Size < ApplicationRecord
  has_many :size_items, dependent: :delete_all
  has_many :products, -> { distinct }, :through => :size_items
end
