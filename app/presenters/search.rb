class Search < ActiveModelSerializers::Model
  include ActiveRecord::Sanitization::ClassMethods
  attr_reader :q, :type, :results
  private

  def initialize(type, q, *columns)
    @q = q || ""
    @type = type
    @results = get_results(columns)
  end

  def get_results(columns)
    model = type.classify.constantize
    query = {query: "%#{sanitize_sql_like(q)}%"}
    sql = columns.map do |column|
      "#{column} ILIKE :query"
    end.join(' OR ')
    model.where(sql, query)
  end

end
