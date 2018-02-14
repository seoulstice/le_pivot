class ApplicationDecorator < SimpleDelegator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def is_a?(mod)
    super(mod) || __getobj__().is_a?(mod)
  end

  class << self
    include ActionView::Helpers::NumberHelper

    delegate :primary_key, to: :model

    def model
      @model ||= name.gsub(/Decorator$/, '').constantize
    end

    def map(raw_collection)
      raw_collection.map &method(:new)
    end

    def define_format(field, &formatter)
      # alias "raw_#{field}" field
      define_method(field){ formatter.call(super()) }
    end

    def formats_currency(field)
      define_format(field) { |price| number_to_currency(price) }
    end

    def formats_datetime(field)
      define_format(field) { |date| date.in_time_zone.strftime('%b. %d, %Y') }
    end

    def belongs_to(association)
      view_model = find_view_model(association)
      define_format(association) { |record| view_model.new(record) }
    end

    alias has_one belongs_to

    def has_many(association, class_name: nil)
      view_model = find_view_model(association || class_name)
      define_format(association) do |records|
        records.map{ |record| view_model.new(record) }
      end
    end

    def find_view_model(association)
      model = association.to_s.classify
      "#{model}Decorator".constantize
    end

    # def self.has_many(association)
    #   view_model = find_view_model(association)
    #   define_method(association) do
    #     super.map{ |record| view_model.new(record)
    #   end
    # end

    # def self.has_many(association, &getter)
    #   view_model = find_view_model(association)
    #   define_format(association, getter) do |relation|
    #     relation.map{ |record| view_model.new(record) }
    #   end
    # end


    # def self.currency(name, &getter)
    #   define_format(name, getter) do |price|
    #     number_to_currency(price)
    #   end
    # end

    # def self.define_format(name, getter = nil, &formatter)
    #   if getter
    #     define_method(name){ formatter.call(getter.call) }
    #   else
    #     define_method(name){ formatter.call(super) }
    #   end
    # end
  end
end
