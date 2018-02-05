class Order < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ["ordered", "paid", "cancelled", "completed"]

  def total_price
    items.sum(:price)
  end

  def order_total_price
    sum = 0
    items.each do |item|
      sum += (item.price * OrderItem.find_by(item: item, order: self).quantity)
    end
    sum
  end

  def find_quantity(item)
    OrderItem.find_by(item: item, order: self).quantity
  end

  def add(item_hash)
    item_hash.each do |item, quantity|
      items << item
      order_item = OrderItem.find_by(order: self, item_id: item.id)
      order_item.update(quantity: quantity)
    end
  end

  def date
    created_at.strftime('%b. %d, %Y')
  end

  def self.count_by_status
    group(:status).count
  end

  def self.filter_by_status(status)
    where(status: status)
  end

  def self.count_of_completed_orders
    where(status: :completed).count
  end

  def self.shop_total_gross
		where(status: :completed).joins(:items).sum(:price)
  end
end
