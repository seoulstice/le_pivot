class TwilioController < ApplicationController

  def new

  end

  def create
    binding.pry
    user = User.find_by(email: user_params[:email])
    TwilioServices.new(user)
    redirect_to twilio_confirmation
  end

  private
    def user_params
      params.require(:reset_password).permit(:email)
    end


end
