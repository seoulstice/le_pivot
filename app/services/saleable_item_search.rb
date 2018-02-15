class SaleableItemSearch < ActiveModelSerializers::Model
  include ActiveRecord::Sanitization::ClassMethods
  attr_reader :q, :type, :results

  def initialize(q)
    @q = q || ""
    @type = "items"
    @results = get_results
  end

  def get_results
    safe_q = { q: "%#{sanitize_sql_like(q)}%" }
    Item.saleable.where('title ILIKE :q OR description ILIKE :q', safe_q).order(:id)
  end

end

# class TextSearch < ActiveModelSerializers::Model
#   include ActiveRecord::Sanitization::ClassMethods
#   attr_reader :q, :type, :results
#
#   private
#
#   def initialize(type, q, *columns)
#     @q = q || ""
#     @type = type
#     @results = get_results(columns)
#   end
#
#   def get_results(columns)
#     model = type.classify.constantize
#     sanitized = { query: "%#{sanitize_sql_like(q)}%" }
#     sql = columns.map do |column|
#       "#{column} ILIKE :query"
#     end.join(' OR ')
#     refine_results(model.where(sql, query))
#   end
#
# end
#
# class SaleableItemSearch < Search
#   def initialize(q)
#     super(q, :items, :title, :description)
#   end
#
#   def refine_results(results)
#     results.saleable
#   end
# end
