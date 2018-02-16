class Store < ApplicationRecord
  has_many :items
  has_many :user_roles
  has_one :twitter_account
  has_many :users, through: :user_roles
  default_scope { order(:id) }

  enum status: ['pending', 'active', 'suspended']

  validates_presence_of :name

  def active_items
    items.active
  end

  def has_twitter?
    twitter_account.present?
  end

  def to_param
    slug
  end

end
