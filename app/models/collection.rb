class Collection < ApplicationRecord
  has_many :products
  has_one :picture, as: :imageable, dependent: :destroy

  validates :title, presence: true
  validates :title, length: {in: 1..50}
  validates :description, length: {maximum: 500}
end
