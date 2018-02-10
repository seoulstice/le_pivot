class StoresController < ApplicationController

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      current_user.user_roles.create(store: @store, role_id: 2)
      flash_success("Store created successfully.")
      redirect_to current_dashboard_path
    else
      flash_errors(@store)
      render :new
    end
  end

  def index
    @stores = current_user.stores
  end

  private

  def store_params
    params.require(:store).permit(:name)
  end
end
