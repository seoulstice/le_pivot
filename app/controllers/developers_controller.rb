class DevelopersController < ApplicationController

  before_action :authenticate!

  def show
    @api_key = current_user.api_key
  end

  def update
    current_user.api_key.reset
    redirect_to developer_path
  end

  def create
    current_user.api_key = ApiKey.unique
    flash_success "You're officially a developer."
    redirect_to developer_path
  end

end
