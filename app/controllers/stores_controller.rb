class StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    store = StoreCreator.create_store(current_user, params[:store][:name])
    if store.save
      flash_success("Store created successfully.")
      redirect_to current_dashboard_path
    else
      flash_errors(store)
      redirect_to new_store_path
    end
  end

  def index
    @stores = StoreDecorator.map(managed_stores)
  end

  def show
    @store = StoreDecorator.new(Store.find_by_slug(params[:slug]))
  end

  def update
    store = managed_stores.find_by_slug(params[:slug])
    if store.update(status: params[:status])
      flash_success
    else
      flash_errors(store)
    end
    redirect_to stores_path
  end

private

  def managed_stores
    if current_user.platform_admin?
      Store.all else current_user.stores
    end
  end

end
