class UserDecorator < ApplicationDecorator

  formats_datetime :created_at

  def full_name
    first_name + " " + last_name
  end

end
