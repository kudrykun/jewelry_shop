class Incrustation < ApplicationRecord
  has_many :incrustation_items
  has_many :products, :through => :incrustation_items
  def self.options_for_incrustation_select
    order('LOWER(title)').map { |e| [e.title, e.id] }
  end
end
