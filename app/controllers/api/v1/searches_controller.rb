class Api::V1::SearchesController < Api::ApiController

  def show
    render json: SaleableItemSearch.new(params[:q])
  end

  # def show
  #   render json: search_class.new(params[:q])
  # end
  #
  # def search_class
  #   case params[:type]
  #   when "items" SaleableItemSearch
  #   else BadSearch
  # end

  # def show
  #   render json: Search.new(
  #     params[:type],
  #     params[:q],
  #     :title,
  #     :description
  #   )
  # end

end
