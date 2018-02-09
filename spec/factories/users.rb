FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.safe_email }
    password "password"

    transient do
      store_roles({})
    end

    after(:create) do |user, evaluator|
      evaluator.store_roles.each do |store, name|
        role = Role.find_or_create_by(name: name)
        UserRole.create(user: user, store: store, role: role)
      end
    end

  end
end
