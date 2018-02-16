class StoresController < ApplicationController

  def index
    @stores = StoreDecorator.map(Store.all)
  end

  def update
    store = Store.find_by_slug!(params[:slug])
    store.status = params[:status]
    try_save(store,
      admin_stores_path,
      admin_stores_path,
      "#{store.name} is now #{store.status}."
    )
  end

end
