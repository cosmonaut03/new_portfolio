FactoryBot.define do
  factory :user do

    email { Faker::Internet.unique.email }
    password { '12345678' }
    password_confirmation { '12345678' }
    # user_name { Faker::Name.user_name }
    user_name { email.split('@').first }

  end

  trait :new_user do
    password_confirmation { nil }
  end

end
