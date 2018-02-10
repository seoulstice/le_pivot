class StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    @store = StoreCreator.create_store(user, store_params)
    binding.pry
    if @store.save
      flash_success("Store created successfully.")
      redirect_to dashboard_path
    else
      flash_errors(@store)
      render :new
    end
  end

  def index
    @stores = current_user.stores
  end

  def show
    @store = Store.find_by(slug: params[:slug])
  end

  private

  def store_params
    params.require(:store).permit(:name)
  end
end
