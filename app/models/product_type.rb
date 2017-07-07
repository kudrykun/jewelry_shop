class ProductType < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :products

  validates :title, presence: true, length: {in: 1..50}
end
