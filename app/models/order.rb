class Order < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ["ordered", "paid", "cancelled", "completed"]

  def status_partial
    if ordered?
      "ordered"
    elsif paid?
      "paid"
    else
       "empty"
    end
  end

  def save_total_price
    self.total_price = order_items.inject(0) do |sum, order_item|
      sum + order_item.price
    end
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
    completed.count
  end

  def self.shop_total_gross
		completed.joins(:items).sum(:price)
  end
end
