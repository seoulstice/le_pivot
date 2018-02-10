class MainController < ApplicationController
  def index
    @popular_items = Item.top_three
  end
end
