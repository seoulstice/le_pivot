class Store < ApplicationRecord
  has_many :items
  has_many :user_roles

  enum status: ["pending", "active", "suspended"]

  validates_presence_of :name
end
