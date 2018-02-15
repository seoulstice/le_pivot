module ApplicationHelper

  def viewer
    @viewer ||= UserDecorator.new(current_user)
  end

end
