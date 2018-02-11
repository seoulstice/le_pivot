class StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    @store = StoreCreator.create_store(current_user, params[:store][:name])
    if @store.save
      flash_success("Store created successfully.")
      redirect_to current_dashboard_path
    else
      flash_errors(@store)
      redirect_to new_store_path
    end
  end

  def index
    if current_user.platform_admin?
      @stores = Store.all.ordered_by_id
    else
      @stores = current_user.stores.ordered_by_id
    end
  end

  def show
    @store = Store.find_by_slug(params[:slug])
  end

  def update
    store = Store.find_by_slug(params[:slug])
    if store.update(status: params[:update_status])
      flash_success
    else
      flash_errors(store)
    end
    redirect_to stores_path
  end

end
