class SaleSize < ApplicationRecord
  has_many :products

  # значения для фильтра по скидкам
  def self.options_for_sale_size_select
    order('LOWER(CAST(sale_percent AS TEXT))').map { |e| [e.sale_percent.to_s, e.id] }
  end
end
