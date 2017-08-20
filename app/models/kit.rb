class Kit < ApplicationRecord
  has_many :products

  validates :title, presence: true, length: {in: 1..50}

  def getKitPrice
    kit_price = 0
    self.products.each do |product|
      if product.price != nil
        kit_price += product.price
      end
    end
    #если в конце метода указываешь значене какое то, то это типа return
    kit_price
  end

  def getKitNewPrice
    kit_price = 0
    self.products.each do |product|
      if product.new_price != nil
        kit_price += product.new_price
      else
        if product.price != nil
          kit_price += product.price
        end
      end
    end
    #если в конце метода указываешь значене какое то, то это типа return
    kit_price
  end

end