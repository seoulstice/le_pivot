class Api::ApiController < ActiveController::Api
  before_action :require_api_key

  def require_api_key
    authed = ApiKey.find_by_key(params[:api_key]).try(:user)
    authed || render json: {
      error: 'bad credentials'
    }
  end
end
