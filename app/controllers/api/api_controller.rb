class Api::ApiController < ActionController::API
  before_action :require_api_key

  def require_api_key
    ApiKey.find_by_key(params[:api_key]).try(:user_id) || unauthorized!
  end

  def unauthorized!
    render status: :unauthorized, json: {
      error: "missing or invalid API key"
    }
  end

end
