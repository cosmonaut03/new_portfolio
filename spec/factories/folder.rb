# == Schema Information
#
# Table name: folders
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  position    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  group_id    :bigint
#  parent_id   :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_folders_on_category_id  (category_id)
#  index_folders_on_group_id     (group_id)
#  index_folders_on_parent_id    (parent_id)
#  index_folders_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (parent_id => folders.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
    factory :folder do
        sequence(:name) { |n|"Sample Folder-#{n}" }
        description { "This is a sample folder" }
        sequence(:position) { |n| n }
        category
        user
    end
end
