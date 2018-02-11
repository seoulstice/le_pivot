class Admin::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash_success
      redirect_to admin_items_path
    else
      flash_errors(@item)
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      flash_success
      redirect_to admin_items_path
    else
      flash_errors(@item)
      render :edit
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def auth
    {
     cloud_name: ENV['CLOUD_NAME'],
     api_key:    ENV['CLOUDINARY_API_KEY'],
     api_secret: ENV['CLOUDINARY_SECRET']
    }
  end

  def handle_image
    if params[:item][:image].nil?
     params[:item][:image] = "http://res.cloudinary.com/tyjoo27/image/upload/v1518213324/cp82cjhrlplyxbet4gko.png"
    else
     response = Cloudinary::Uploader.upload(params[:item][:image].tempfile.path, auth)
     params[:item][:image] = response['url']
    end
  end

  def item_params
    handle_image
    params.require(:item).permit(:title, :description, :price, :image, :category_id)
  end

end
