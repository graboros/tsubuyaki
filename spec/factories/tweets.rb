FactoryGirl.define do
  factory :tweet do

    factory :tweet1 do
      content "MyString"
    end

    factory :long_tweet do
      user :user1
      content { Faker::Lorem.characters(140) }
    end

    factory :too_long_tweet do
      user :user1
      content { Faker::Lorem.characters(141) }
    end
  end
end
