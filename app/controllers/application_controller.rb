class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :cart, :current_admin? 
  before_action :set_categories


private

  def require_login
    redirect_to login_path unless current_user
  end

  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def flash_success(message)
    flash[:success] = message
  end

  def flash_errors(record)
    flash[:error] = record.errors.full_messages.join("\n")
  end

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def set_categories
    @categories = Category.all
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
