class TwitterAccount < ApplicationRecord

  belongs_to :user

  validates_uniqueness_of :uid
  validates_presence_of :screen_name,
                        :oauth_token,
                        :oauth_token_secret


  def send_tweet(content)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = oauth_token
      config.access_token_secret = oauth_token_secret
    end
    client.update(content)
  end

end
