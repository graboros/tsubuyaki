FactoryGirl.define do
  factory :user do

    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    password { Faker::Internet.password }

    factory :user1 do
      email "takashi2003_jp@yahoo.co.jp"
      username "takashi"
      password "password"
    end

    factory :user2 do
      email "graboros.dev@gmail.com"
      username "graboros"
    end

    factory :user3 do
      email "graboros_ro@hotmail.com"
      username "graboros_ro"
    end
  end
end
