class SizeItem < ApplicationRecord
  belongs_to :product
  belongs_to :shop
  belongs_to :size
end
