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
    authenticate!
    current_user.assign_attributes(user_params)
    try_save(current_user, edit_user_path, edit_user_path, "Successfully updated your account information.")
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
