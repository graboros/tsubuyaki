FactoryGirl.define do
  factory :profile do
    introduction { Faker::Lorem.characters(10) }
    image ""

    factory :profile1 do
      introduction { Faker::Lorem.characters(141) }
    end

    factory :profile2 do
      introduction "other introduction"
    end
  end
end
