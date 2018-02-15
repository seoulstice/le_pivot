class TwilioController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: user_params[:email])
    if user
      TwilioServices.new(user).send_message
      recovery = PasswordRecovery.where(user_id: user.id).last
      redirect_to twilio_confirmation_path(lookup: recovery.id)
    else
      flash[:error] = "We weren't able to locate your account. Please ensure your email was entered correctly."
      redirect_to twilio_new_path
    end
  end

  def confirm
    @lookup = params[:lookup]
  end

  def validate_key
    recovery = PasswordRecovery.find(params[:password_reset][:lookup])
    code = recovery.code
    user_code = params[:password_reset][:key]
    if code == user_code
      session[:user_id] = recovery.user_id
      redirect_to edit_user_password_path
    else
      flash[:error] = "Sorry, that wasn't the correct key, please try again."
      redirect_to twilio_new_path
    end
  end

  private
    def user_params
      params.require(:reset_password).permit(:email)
    end


end
