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
class Category < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :group, optional: true
  has_many :home_layouts, foreign_key: :user_id, primary_key: :user_id
  has_many :folders, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true
  validates :position, presence: true
  validates :is_uncategorized, uniqueness: { scope: :user_id, if: -> { user_id.present? && is_uncategorized? } }
  validates :is_uncategorized, uniqueness: { scope: :group_id, if: -> { group_id.present? && is_uncategorized? } }

  # フォルダを持たないブックマークを格納
  attr_accessor :bookmarks_without_folder

  # ---------------------
  # ユーザーの初期データ作成
  # ---------------------
  def self.create_default_for_user(user_id)
    create(
      user_id:,
      group_id: nil,
      name: 'uncategorized',
      position: get_new_position_for_user(user_id),
      is_uncategorized: true
    )
  end

  # ---------------------
  # カテゴリの配置位置を取得
  # ---------------------
  def self.get_new_position_for_user(user_id)
    where(user_id:).maximum(:position).to_i + 1
  end
end
