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
require 'rails_helper'
RSpec.describe Bookmark, type: :model do
    describe 'ブックマークのバリデーションテスト' do
        let(:user) { create(:user) }
        let(:category) { create(:category, user: user) }
        let(:folder) { craete(:folder, user: user, category: category) }
        let(:bookmark) { build(:bookmark, user: user, category: category, folder: folder )}

        context 'カラムのバリデーションチェック' do
            it 'titleが未入力の場合エラーとなること' do
                bookmark.title = ''
                bookmark.valid?
                expect(bookmark.errors[:title]).to include('タイトルを入力してください。')
            end

            it 'urlが未入力の場合エラーとなること' do
                bookmark.url = ''
                bookmark.valid?
                expect(bookmark.errors[:title]).to include('URLを入力してください。')
            end

            it 'type初期値' do
                expect(bookmark.type).to eq(0)
            end
        end

        context '正常登録' do
            it 'データが条件を満たすとき保存できること' do
              expect(bookmark).to be_valid
            end
        end
    end
end
