require 'twilio-ruby'

class TwilioServices

  def initialize(user)
    @user = user
  end

  def create_client
    @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

  def generate_key
    @key = (0...7).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def format_phone
    @phone = @user.phone.delete "(", ")", "-"
  end

  def send_message
    format_phone
    @client.messages.create(
      to: "+#{@ohone}",
      from: "+9894944423",
      body: @key
    )
  end

end
