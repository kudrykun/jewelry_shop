class ProductPromo < ApplicationRecord
  belongs_to :product
  belongs_to :promo
end