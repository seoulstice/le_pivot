class Api::V1::SearchesController < Api::ApiController

  def show
    render json: Search.new(
      params[:type],
      params[:q],
      :title,
      :description
    )
  end

end
