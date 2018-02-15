require 'twilio-ruby'

class TwilioServices

  def initialize(user = nil)
    @user = user
  end

  def generate_key
    (0...6).map { ('a'..'z').to_a[rand(26)] }.join.upcase
  end

  def format_phone
    @user.phone.delete(" ()-")
  end

  def create_client
    Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

  def send_message
    create_client.messages.create(
      to: "+1#{format_phone}",
      from: "+19894944423",
      body: "Your password reset key is #{generate_key}"
)
  end

  def retrieve_last_key
    create_client.messages.list.first.body[-6..-1]
  end

end
