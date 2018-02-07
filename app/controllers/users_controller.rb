class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    flash[:notice] = "Logged in as #{user.first_name} #{user.last_name}"
    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def edit
    @user = current_user
  end

  def update
    if current_admin?
      current_user.update(user_params)
      redirect_to admin_dashboard_path
    elsif current_user
      current_user.update(user_params)
      redirect_to dashboard_path
    else
      not_found
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :address)
  end

end
