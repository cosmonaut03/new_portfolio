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
class HomeLayout < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :categories, through: :user

  # ユーザ個人の初期データ作成
  def self.create_default_for_user(user_id)
    create(
      user_id:,
      group_id: nil,
      is_visible: true,
      position: 1,
      is_personal: true
    )
  end
end
