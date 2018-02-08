class Api::V1::SearchesController < Api::ApiController

  def show
    render json: Search.new(
      params[:type],
      params[:query],
      :title,
      :description
    )
  end

  class Search
    attr_reader :q, :type, :results

    def initialize(type, query, *columns)
      @q = query
      @type = type
      @results = results(columns)
    end

    def results(*columns)
      query = sanitize_sql_like("%#{@q}%")
      model = @type.classify.constantize
      sql = columns.map do |column|
        "#{column} LIKE :query"
      end.join(' OR ')

      model.where(sql, query)
    end

  end

end
