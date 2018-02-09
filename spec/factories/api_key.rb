FactoryBot.define do
  factory :api_key do
    user
    
    key { SecureRandom.urlsafe_base64 }
  end
end
