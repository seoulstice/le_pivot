class Admin::BaseController < ApplicationController

  before_action :require_admin

  def require_admin
    not_found unless current_admin?
  end

end
