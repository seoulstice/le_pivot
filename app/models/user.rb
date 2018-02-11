class User < ApplicationRecord

  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :stores, through: :user_roles
  has_one :api_key, dependent: :nullify
  has_one :twitter_account, dependent: :destroy

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :email
  has_secure_password

  def self.guest
    new(first_name: 'guest', last_name: 'user')
  end

  def self.user_orders
    group(:email).joins(:orders).count
  end

  def self.user_quantity_of_items_ordered
    group(:email).joins(orders: :order_items).sum(:quantity)
  end

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def admin?
    roles.exists?(name: ["platform_admin", "store_admin"])
  end

  def management?
    roles.exists?
  end

  def registered?
    persisted?
  end

end
