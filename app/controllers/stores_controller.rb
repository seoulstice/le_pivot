class StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      UserRole.create!(user_id: current_user.id, store: @store, role_id: 2)
      flash_success("Store created successfully.")
      redirect_to dashboard_path
    else
      flash_errors(@store)
      render :new
    end
  end

  def index
    if current_user.platform_admin?
      @stores = Store.all.ordered_by_id
    else
      @stores = current_user.stores.ordered_by_id
    end
  end

  def update
    store = Store.find(params[:id])
    store.status = (params[:update_status])
    store.save
    redirect_to stores_path
  end

  private

  def store_params
    params.require(:store).permit(:name)
  end
end
