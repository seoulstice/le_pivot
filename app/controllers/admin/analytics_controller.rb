class Admin::AnalyticsController < ApplicationController

  def show
    @analytics = AdminAnalyticsPresenter.new
  end

end
