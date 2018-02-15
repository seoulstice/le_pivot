class Category < ApplicationRecord
  extend FriendlyId

  has_many :items
  validates :title, :slug, presence: true
  friendly_id :title, use: :slugged

  def to_param
    slug
  end

end
