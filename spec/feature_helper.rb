module FeatureHelper
  def stub_logged_in_user(user = create(:user))
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  def todays_date
    DateTime.now.in_time_zone.strftime('%b. %d, %Y')
  end

end
