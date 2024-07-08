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
class Folder < ApplicationRecord
  belongs_to :category
  belongs_to :group, optional: true
  belongs_to :user, optional: true
  # 親フォルダーは同じ Folder クラスの他のフォルダ
  belongs_to :parent, class_name: 'Folder', optional: true
  # parent_id カラムが folders テーブルの id カラムを参照する
  has_many :subfolders, class_name: 'Folder', foreign_key: 'parent_id', dependent: :destroy

  validates :name, presence: true
  validates :position, presence: true

  # ---------------------
  # folderの配置位置を取得
  # ---------------------
  def self.get_new_position_folder(category_id)
    where(category_id:).maximum(:position).to_i + 1
  end
end
