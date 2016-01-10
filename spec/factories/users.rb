FactoryGirl.define do
  factory :user do

    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    password { Faker::Internet.password }

    factory :user1 do
      email "takashi2003_jp@yahoo.co.jp"
      username "takashi"
    end

    factory :user2 do
      email "graboros.dev@gmail.com"
      username "graboros"
    end

  end
end
