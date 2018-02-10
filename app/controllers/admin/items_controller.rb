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

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :category_id)
  end

end
