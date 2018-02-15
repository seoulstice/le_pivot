class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    session[:user_id] = user.id if try_save(
      user, dashboard_path, new_user_path,
      "Welcome, #{user.first_name}!"
    )
  end

  def edit
    authenticate!
    @user = current_user
  end

  def update
    binding.pry
    authenticate!
    current_user.assign_attributes(user_params)
    try_save(current_user, current_dashboard_path, edit_user_path,
      "Your changes are saved")
  end

  def password_reset
    @user = current_user
  end

  def password_update
    user = User.find(params[:password_reset][:user_id])
    user.password = (params[:password_reset][:new_password])
    if user.save
      flash[:success] = "Your password has been successfully updated!"
      redirect_to dashboard_path(user)
    else
      flash[:error] = "We're sorry, something went wrong. Please try again"
      redirect_to twilio_new_path
    end
  end

  private

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :address,
        :username
      )
    end

end
