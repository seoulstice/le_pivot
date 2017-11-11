class Category < ApplicationRecord
  has_many :items
  validates :title, :slug, presence: true
  extend FriendlyId
  friendly_id :title, use: :slugged


end
