# == Schema Information
#
# Table name: categories
#
#  id               :bigint           not null, primary key
#  description      :text
#  is_uncategorized :boolean          default(FALSE), not null
#  name             :string           not null
#  position         :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  group_id         :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_categories_on_group_id                       (group_id)
#  index_categories_on_group_id_and_is_uncategorized  (group_id,is_uncategorized) UNIQUE WHERE (is_uncategorized = true)
#  index_categories_on_user_id                        (user_id)
#  index_categories_on_user_id_and_is_uncategorized   (user_id,is_uncategorized) UNIQUE WHERE (is_uncategorized = true)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
    factory :category do
      name { "test_category" }
      description { "test_description" }
      position { 2 }
      user
    end
    
    trait :is_personal do
      is_uncategorized { true }
      name { "uncategorized" }
      position { 1 }
    end
end