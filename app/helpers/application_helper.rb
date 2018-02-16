module ApplicationHelper

  def viewer
    @viewer ||= UserDecorator.new(current_user)
  end

  def navlink(title, path)
    link_to title, path, class: "nav-item nav-link"
  end

end
