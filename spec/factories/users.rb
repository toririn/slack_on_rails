FactoryGirl.define do
  factory :user do
    id        { Faker::Lorem.characters(6) }
    name      { Faker::Name.first_name }
    last_auth { Time.zone.yesterday }

    factory :old_login_user do
      last_auth { Time.zone.now.ago(15.day) }
    end

    factory :empty_id_user do
      id        { nil }
    end

    factory :empty_name_user do
      name      { nil }
    end
  end
end
