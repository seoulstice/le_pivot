class Item < ApplicationRecord
  belongs_to :store
  belongs_to :category
  belongs_to :store
  has_many :order_items
  has_many :orders, through: :order_items

  validates :title, presence: true, uniqueness: true
  validates :description, :price, presence: true
  enum condition: ["active", "retired"]

  scope :saleable, -> { active.joins(:store).merge(Store.active) }

  def self.top_three
    select('items.*, sum(order_items.quantity) as total_sold')
      .joins(:order_items)
      .group(:id)
      .order('total_sold DESC')
      .first(3)
  end

  def self.total_sold_by_item
    group(:title).joins(:order_items).sum(:quantity)
  end
end
