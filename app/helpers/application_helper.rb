module ApplicationHelper
  def viewer
    @viewer ||= Viewer.new(current_user)
  end
end
