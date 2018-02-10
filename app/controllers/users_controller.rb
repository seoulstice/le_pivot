class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash_success "Logged in as #{user.first_name} #{user.last_name}"
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash_errors(@user)
      render :new
    end
  end

  def edit
    authenticate!
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :address)
  end

end
