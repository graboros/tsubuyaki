# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do

    factory :user1 do
      email "takashi2003_jp@yahoo.co.jp"
      username "takashi"
      password "password"
    end

    factory :user2 do
      email "graboros.dev@gmail.com"
      username "graboros"
      password "password"
    end

  end
end
