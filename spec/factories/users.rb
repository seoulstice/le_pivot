FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.safe_email }
    password "password"
    username { Faker::Name.unique.first_name}

    factory(:store_manager) do
      store_roles({store => "store_manager"})
    end

    factory(:store_admin) do
      store_roles({store => "store_admin"})
    end

    factory(:platform_admin) do
      store_roles({nil => "platform_admin"})
    end

    transient do
      store_roles({})
      store(nil)
    end

    after(:create) do |user, evaluator|
      evaluator.store_roles.each do |store, name|
        role = Role.find_or_create_by(name: name)
        store = evaluator.store || create(:store) unless name.to_s == "platform_admin"
        UserRole.create!(user: user, store: store, role: role)
      end
    end

  end
end
