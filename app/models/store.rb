class Store < ApplicationRecord
  has_many :items
  has_many :user_roles
  scope :ordered_by_id, -> {order(:id)}

  enum status: ['pending', 'active', 'suspended']

  validates_presence_of :name

  def active_items
    items.active
  end

  def to_param
    slug
  end

end
