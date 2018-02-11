class User < ApplicationRecord

  has_secure_password
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_one :api_key, dependent: :nullify
  has_one :twitter_account, dependent: :destroy
  has_many :user_roles
  has_many :stores, through: :user_roles
  has_many :roles, through: :user_roles
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, :on => :create
  validates :email, presence: true, uniqueness: true
  has_many :messages
  has_many :chatrooms, through: :messages
  validates :username, presence: true, uniqueness: true

  def self.guest
    new(first_name: 'guest', last_name: 'user')
  end

  def full_name
    first_name + " " + last_name
  end

  def date_joined
    created_at.strftime('%b. %d, %Y')
  end

  def self.user_orders
    group(:email).joins(:orders).count
  end

  def self.user_quantity_of_items_ordered
    group(:email).joins(orders: :order_items).sum(:quantity)
  end

  def has_role?(name)
    roles.exists?(name: name)
  end

  def platform_admin?
    has_role?("platform_admin")
  end

end
