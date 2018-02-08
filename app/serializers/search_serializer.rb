class SearchSerializer < ActiveModel::Serializer
  attributes :type, :q

  has_many :results

  class ItemSerializer < ActiveModel::Serializer
    include ActionView::Helpers::NumberHelper
    attributes :id, :title, :description, :price
    def price
      number_to_currency(object[:price])
    end
  end

end
