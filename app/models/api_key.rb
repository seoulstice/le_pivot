class ApiKey < ApplicationRecord

  belongs_to :user, optional: true

  before_destroy { throw :abort }
  def self.delete(*args)
    raise 'API keys must never be deleted'
  end

  def self.unique
    loop do
      key = SecureRandom.urlsafe_base64
      return create(key: key) unless exists?(key: key)
    end
  end

  def reset
    user && user.api_key = self.class.unique
  end

  def to_s
    key
  end

end
