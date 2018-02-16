class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:provider].present?
      @user = User.from_omniauth(request.env['omniauth.auth'])
      login_successful
    else
      @user = User.find_by(email: params[:session][:email])
      verify_user
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

private

  def verify_user
    if @user.try(:authenticate, params[:session][:password])
      login_successful
    else
      flash_error "That login was unsuccessful"
      redirect_to login_path
    end
  end

  def login_successful
    session[:user_id] = @user.id
    if current_user.platform_admin?
      flash_success "You're logged in as an Administrator."
    else
      flash_success "<h4 class=\"card-title\">Welcome back, #{current_user.first_name}!</h4>"
    end
    redirect_to dashboard_path
  end

end
