class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.available_to(user)
    if user.platform_admin?
    end
  end

  scope :actually_all!, -> { unscope :where }
  def available_to(user)
    if user.platform_admin?
      actually_all! else all
    end
  end

end
