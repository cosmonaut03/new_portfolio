# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  avatar           :string
#  crypted_password :string
#  email            :string           not null
#  name             :string
#  salt             :string
#  user_name        :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
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
