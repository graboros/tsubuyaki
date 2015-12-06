# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retweeting_relationship do
    tweet nil
    tweeted nil
  end
end
