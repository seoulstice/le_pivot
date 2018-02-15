class ItemsController < ApplicationController

	def show
		@item = ItemDecorator.new(Item.find(params[:id]))
	end

end
