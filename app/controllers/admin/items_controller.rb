class Admin::ItemsController < ApplicationController

  def index
    @items = ItemDecorator.map(Item.all)
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if try_save(item, admin_items_path, new_admin_item_path, nil)
      flash_success "New item #{success_link(item)} added."
    end
  end

  def update
    item = Item.find(params[:id])
    item.assign_attributes(item_params)
    try_save(item, admin_items_path, edit_admin_item_path(item),
      "Item #{success_link(item)} updated.")
  end

  def edit
    @item = Item.find(params[:id])
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

end
