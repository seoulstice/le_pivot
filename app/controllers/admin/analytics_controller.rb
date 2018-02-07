class Admin::AnalyticsController < Admin::BaseController

  def show
    @analytics = AdminAnalyticsPresenter.new
  end

end
