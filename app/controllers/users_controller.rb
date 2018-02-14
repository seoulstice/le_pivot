class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash_success "Logged in as #{current_user.first_name} #{current_user.last_name}"
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash_errors(@user)
      render :new
    end
  end

  def edit
    authenticate!
    @user = current_user
  end

  def update
    authenticate!
    @user = current_user
    if @user.update(user_params)
      flash_success
      redirect_to current_dashboard_path
    else
      flash_errors(@user)
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :address, :username)
  end

end
