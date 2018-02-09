class OrderItem < ApplicationRecord
  belongs_to :order, inverse_of: :order_items
  belongs_to :item, inverse_of: :order_items

  def self.average_quantity
    average(:quantity).to_i
  end

end
