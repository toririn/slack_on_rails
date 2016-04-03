FactoryGirl.define do
  factory :channel do
    id           { Faker::Lorem.characters(6) }
    name         { Faker::Lorem.characters(10) }
    introduction { Faker::Lorem.sentence }

    factory :times_channel do
      name         { "times_" + Faker::Name.first_name }
    end

    factory :otacks_channel do
      name         { "times_" + Faker::Lorem.characters(6) }
    end

    factory :kbs_channel do
      name         { "kb_"    + Faker::Lorem.characters(6) }
    end
  end

end
