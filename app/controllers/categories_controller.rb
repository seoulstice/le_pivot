class CategoriesController < ApplicationController
	def show
			@category = Category.friendly.find(params[:category_slug])
	end
end
