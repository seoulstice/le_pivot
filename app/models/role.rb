class Role < ApplicationRecord
  has_many :user_roles
  enum name: ["registered_user", "store_manager", "store_admin", "platform_admin"]
end
