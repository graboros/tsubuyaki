FactoryGirl.define do
  factory :profile do
    introduction { Faker::Lorem.characters(10) }
    image { Faker::Avatar.image }

    factory :profile1 do
      introduction { Faker::Lorem.characters(61) }
    end

    factory :profile2 do
      introduction "other introduction"
    end

    factory :large_profile do
      introduction { Faker::Lorem.characters(60) }
    end

    factory :too_large_profile do
      introduction { Faker::Lorem.characters(61) }
    end

    factory :profile_without_image do
      image nil
    end

    factory :profile_with_image do
      image "moritamori.png"
    end
  end
end
