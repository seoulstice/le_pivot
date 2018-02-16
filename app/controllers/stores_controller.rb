class StoresController < ApplicationController

  def show
    @store = StoreDecorator.new(Store.find_by_slug!(params[:slug]))
  end

  def index
    @stores = StoreDecorator.map(current_user.reload.stores)
  end

  def new
    @store = Store.new
  end

  def edit
    @store = current_user.stores.find_by_slug!(params[:slug])
  end

  def create
    store = StoreCreator.create_store(current_user, params[:store][:name])
    try_save(store,
      dashboard_path,
      new_store_path,
      'Your store is registered, now go sell some art!'
    )
  end

  def update
    store = current_user.stores.find_by_slug!(params[:slug])
    store.assign_attributes(store_params)
    try_save(store,
      store_path(store),
      edit_store_path(store),
      'Your store is updated.'
    )
  end

private

  def store_params
    params.require(:store).permit(:name)
  end

end
