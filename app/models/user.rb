class User < ApplicationRecord

  has_secure_password
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_one :api_key, dependent: :nullify
  has_many :user_roles
  has_many :stores, through: :user_roles
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, :on => :create
  validates :email, presence: true, uniqueness: true

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

  def has_role(name)
    roles.exists?(name: name)
  end

  def platform_admin?
    has_role("platform_admin")
  end

  def add_twitter_credentials(auth_hash)
    self.uid                =  auth_hash.uid
    self.screen_name        =  auth_hash.extra.raw_info.screen_name
    self.oauth_token        =  auth_hash.credentials.token
    self.oauth_token_secret =  auth_hash.credentials.secret
    save
  end

  def send_tweet(content)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = oauth_token
      config.access_token_secret = oauth_token_secret
    end

    client.update(content)
  end

  # def self.from_omniauth(auth_info)
  #   where(uid: auth_info[:uid]).first_or_create do |new_user|
  #     new_user.uid                = auth_info.uid
  #     new_user.screen_name        = auth_info.extra.raw_info.screen_name
  #     new_user.oauth_token        = auth_info.credentials.token
  #     new_user.oauth_token_secret = auth_info.credentials.secret
  #   end
  # end

end
