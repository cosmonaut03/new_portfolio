# == Schema Information
#
# Table name: bookmarks
#
#  id          :bigint           not null, primary key
#  description :text
#  position    :integer          not null
#  title       :string           not null
#  type        :integer          default(0), not null
#  url         :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  folder_id   :bigint
#  group_id    :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_bookmarks_on_category_id  (category_id)
#  index_bookmarks_on_folder_id    (folder_id)
#  index_bookmarks_on_group_id     (group_id)
#  index_bookmarks_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (folder_id => folders.id)
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
class Bookmark < ApplicationRecord
  # アソシエーション
  belongs_to :user, optional: true
  belongs_to :group, optional: true
  belongs_to :category, optional: true
  belongs_to :folder, optional: true

  # バリデーション
  validates :title, presence: true
  validates :url, presence: true
  validates :type, presence: true
  validates :position, presence: true

  # validate :user_or_group_presence
  attr_accessor :image_url

  enum type: { link: 0, movie: 1 }, _suffix: :type
  self.inheritance_column = :_type_disabled

  # ---------------------
  # bookmarkの配置位置を取得
  # ---------------------
  def self.get_new_position_bookmark(bookmark)
    where(category_id: bookmark.category_id, folder_id: bookmark.folder_id).maximum(:position).to_i + 1
  end

  def fetch_thumbnail
    agent = Mechanize.new
    page = agent.get(self.url)
    # ここではOGP画像を取得する例を示すダ
    og_image = page.at('meta[property="og:image"]')
    self.image_url = og_image ? og_image['content'] : 'sample.jpg'
  rescue
    self.image_url = 'sample.jpg'
  end

    # def user_or_group_presence
    #   if user_id.nil? && group_id.nil?
    #     errors.add(:base, 'User or Group must be present')
    #   elsif user_id.present? && group_id.present?
    #     errors.add(:base, 'User and Group cannot both be present')
    #   end
    # end
end
