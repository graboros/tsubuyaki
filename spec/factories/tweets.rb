# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do

    factory :tweet1 do
      content "MyString"
    end

    factory :long_tweet do
      user :user1
      content "aaaaaaaaaaiiiiiiiiiiuuuuuuuuuueeeeeeeeeeuuuuuuuuuuooooooooookkkkkkkkkkssssssssssttttttttttnnnnnnnnnnhhhhhhhhhhmmmmmmmmmmyyyyyyyyyyrrrrrrrrrr"
    end

    factory :too_long_tweet do
      user :user1
      content "aaaaaaaaaaiiiiiiiiiiuuuuuuuuuueeeeeeeeeeuuuuuuuuuuooooooooookkkkkkkkkkssssssssssttttttttttnnnnnnnnnnhhhhhhhhhhmmmmmmmmmmyyyyyyyyyyrrrrrrrrrrz"
    end
  end
end
