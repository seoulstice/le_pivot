require 'twilio-ruby'

class TwilioServices
  attr_reader :user

  def initialize(user = nil)
    @user = user
  end

  def generate_code
    (0...6).map { ('a'..'z').to_a[rand(26)] }.join.upcase
  end

  def format_phone
    user.phone.delete(" ()-")
  end

  def create_client
    Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

  def create_recovery_record(code)
    PasswordRecovery.create(code: code, user: user)
  end

  def send_message
    code = generate_code
    create_recovery_record(code)
    create_client.messages.create(
      to: "+1#{format_phone}",
      from: "+19894944423",
      body: "Your password reset key is #{code}"
)
  end

end
