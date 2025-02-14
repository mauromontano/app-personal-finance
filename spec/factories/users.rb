# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      email { "user@example.com" }
      password { "Password!" }
      password_confirmation { "Password!" }
    end
end

# spec/factories/categories.rb
FactoryBot.define do
    factory :category do
        name { "Food" }
    end
end
