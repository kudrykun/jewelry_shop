class Manufacturer < ApplicationRecord
  has_many :products
  validates :title, presence: true, length: {in: 1..50}
end
