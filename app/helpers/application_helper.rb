module ApplicationHelper
  def viewer
    @viewer ||= Viewer.new(current_user)
  end

  def badge(badge)
    "badge badge-#{badge}"
  end
end
