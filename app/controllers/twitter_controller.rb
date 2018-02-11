class TwitterController < ApplicationController

  def new
  end

  def create
    current_user.twitter_account.tweet(params[:text])
    redirect_to current_dashboard_path
  end

  def update
    data = extract_account_data(request.env['omniauth.auth'])
    if build_account(data).save
      flash_success "Successfully paired Twitter account for #{current_user.first_name} #{current_user.last_name}"
      redirect_to current_dashboard_path
    else
      flash[:error] = 'Something went wrong and we were unable to conntect your account.'
      redirect_to current_dashboard_path
    end
  end

  private

    # I get UID for uniqueness
    # , but why do we need their screen name?
    def build_account(raw_data)
      current_user.build_twitter_account(
        uid:                  raw_data.uid
        screen_name:          raw_data.extra.raw_info.screen_name
        oauth_token:          raw_data.credentials.token
        oauth_token_secret:   raw_data.credentials.secret
      )
    end

end
