class Incrustation < ApplicationRecord
  has_many :incrustation_items
  has_many :products, :through => :incrustation_items
end
