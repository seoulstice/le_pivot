class TweetsController < ApplicationController

  before_action :set_store

  def new
  end

  def create
    @store.twitter_account.tweet(params[:text])
    redirect_to stores_path
  end

  private

    def store
      @store = current_user.stores.find(params[:slug])
    end

end
