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
      flash[:error] = "That login was unsuccessful"
      redirect_to login_path
    end
  end

  def login_successful
    session[:user_id] = @user.id
    if current_user.admin?
      flash_success "You're logged in as an Administrator."
    else
      flash_success "Logged in as #{@user.first_name} #{@user.last_name}"
    end

    redirect_to current_dashboard_path
  end

end
