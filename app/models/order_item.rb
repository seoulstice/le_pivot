class OrderItem < ApplicationRecord
  belongs_to :order, inverse_of: :order_items
  belongs_to :item, inverse_of: :order_items

  validates_presence_of :quantity

  def self.average_quantity
    average(:quantity)
  end

  def subtotal
    quantity * item.price
  end

end
