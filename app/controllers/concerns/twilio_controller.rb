class TwilioController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: user_params[:email])
    if user
      twilio = TwilioServices.new(user)
      twilio.generate_key
      twilio.create_client
      twilio.send_message
      redirect_to password_confirmation_path
    else
      flash[:error] = "We weren't able to locate your account. Please ensure your email was entered correctly."
      redirect_to twilio_new_path
    end
  end

  private
    def user_params
      params.require(:reset_password).permit(:email)
    end


end
