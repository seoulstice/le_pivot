class MainController < ApplicationController
  def index
    @popular_items = ItemDecorator.map(Item.top_three)
  end
end
