# == Schema Information
#
# Table name: home_layouts
#
#  id          :bigint           not null, primary key
#  is_personal :boolean          default(FALSE)
#  is_visible  :boolean          default(TRUE)
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  group_id    :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_home_layouts_on_group_id  (group_id)
#  index_home_layouts_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
    factory :home_layout do
        position  { 1 }
        user
    end
  
    trait :personal do
        is_personal { true }
    end
end
  