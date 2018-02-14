class TwitterController < ApplicationController

  def new
    data = extract_account_data(request.env['omniauth.auth'])
    @account = TwitterAccount.new(data)
  end

  def create
    @account = TwitterAccount.new(twitter_params)
    if @account.save
      flash_success "Your Twitter account for #{store.name} has been linked"
      redirect_to stores_path
    else
      flash_errors(@account)
      render :new
    end
  end

  private

    def twitter_account_params
      params.require(:twitter_account).permit(
        :uid,
        :screen_name,
        :oauth_token,
        :oauth_token_secret,
        :store_id
      )
    end

    def extract_account_data(raw_data)
      {
        uid:                  raw_data.uid
        screen_name:          raw_data.extra.raw_info.screen_name
        oauth_token:          raw_data.credentials.token
        oauth_token_secret:   raw_data.credentials.secret
      }
    end

end
