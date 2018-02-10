class TwitterController < ApplicationController

  def new
  end

  def create
    current_user.send_tweet(params[:text])
    redirect_to admin_dashboard_path
  end

  def update
    current_user.add_twitter_credentials(request.env['omniauth.auth'])
    twitter_successful
  end

  private

    def twitter_successful
      flash[:notice] = "Successfully paired Twitter account for #{current_user.first_name} #{current_user.last_name}"
      redirect_to admin_dashboard_path
    end

end
