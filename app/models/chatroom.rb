class Chatroom < ApplicationRecord
  before_save :generate_slug
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  validates :topic, presence: true, uniqueness: true, case_sensitive: false

  def generate_slug
    self.slug ||= topic.parameterize
  end

  def to_param
    slug
  end

end
