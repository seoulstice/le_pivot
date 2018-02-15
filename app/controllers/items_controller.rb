class ItemsController < ApplicationController

  before_action :set_store, except: :show

	def show
		@item = ItemDecorator.new(Item.find(params[:id]))
	end

  def new
    @item = @store.items.new
  end

  def create
    @item = @store.items.new(item_params)
    if try_save(@item, store_path(@store), nil)
      flash_success "New item #{success_link(@item)} added."
    end
  end

  def update
    @item = @store.items.find(params[:id])
    @item.assign_attributes(item_params)
    try_save(@item, store_path(@store), "Item #{success_link(@item)} updated.")
  end

  def edit
    @item = @store.items.find(params[:id])
  end

  private

    def item_params
      upload_or_default_image_param
      params.require(:item).permit(:title, :description, :price, :image, :category_id)
    end

    def upload_or_default_image_param
      params[:item][:image] &&= upload_image['url']
      params[:item][:image] ||= "http://res.cloudinary.com/tyjoo27/image/upload/v1518213324/cp82cjhrlplyxbet4gko.png"
    end

    def upload_image
      Cloudinary::Uploader.upload(params[:item][:image].tempfile.path, auth)
    end

    def auth
      {
        cloud_name: ENV['CLOUD_NAME'],
        api_key:    ENV['CLOUDINARY_API_KEY'],
        api_secret: ENV['CLOUDINARY_API_SECRET']
      }
    end

    def success_link(item)
      "<a href=#{(item_path(item))}>#{item.title}</a>"
    end

    def set_store
      @store = Store.find_by_slug!(params[:store_slug])
    end

end
