class Admin::AnalyticsController < ApplicationController
  before_action :require_admin

  def index
    @analytics = AdminAnalyticsPresenter.new
  end
end
