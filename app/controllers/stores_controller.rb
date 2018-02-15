class StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    store = StoreCreator.create_store(current_user, params[:store][:name])
    try_save(store, current_dashboard_path, new_store_path,
      'Your store is registered, now go sell some art!')
  end

  def index
    @stores = StoreDecorator.map(managed_stores)
  end

  def show
    @store = StoreDecorator.new(Store.find_by_slug!(params[:slug]))
  end

  def update
    store = managed_stores.find_by_slug!(params[:slug])
    store.status = params[:status]
    try_save(store, stores_path, stores_path, "Store status updated")
  end

private

  def managed_stores
    if current_user.platform_admin?
      Store.all else current_user.stores
    end
  end

end
