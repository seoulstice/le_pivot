class TwilioController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: user_params[:email])
    if user
      TwilioServices.new(user).send_message
      redirect_to twilio_confirmation_path
    else
      flash[:error] = "We weren't able to locate your account. Please ensure your email was entered correctly."
      redirect_to twilio_new_path
    end
  end

  def confirm

  end

  def validate_key
    random_key = TwilioServices.new.retrieve_last_key
    user_key = params[:password_reset][:key]
    if random_key == user_key
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
