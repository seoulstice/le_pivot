class ApiKey < ApplicationRecord

  belongs_to :user, optional: true
  before_destroy { raise 'API keys must never be deleted' }

  def self.unique
    key = SecureRandom.urlsafe_base64
    key = SecureRandom.urlsafe_base64 while exists?(key: key)
    create(key: key)
  end

  def reset
    user.api_key = self.class.unique
  end

  def to_s
    key
  end

end
