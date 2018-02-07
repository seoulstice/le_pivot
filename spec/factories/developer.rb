FactoryBot.define do
  factory :developer do
    user
    api_key { SecureRandom.urlsafe_base64 }
  end
end
