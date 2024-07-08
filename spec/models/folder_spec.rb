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
require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'フォルダのバリデーションテスト' do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }
    let(:folder) { build(:folder, user: user, category: category) }

    context 'データが条件を満たすとき' do
        it '保存できる' do
          expect(folder).to be_valid
        end
    end

    context 'nameが空のとき' do
        it 'エラーが発生する' do
            folder.name = ''
            expect(folder).not_to be_valid
            expect(folder.errors.messages[:name]).to include 'を入力してください'
        end
    end

    context 'category_idが空のとき' do
        it 'エラーが発生する' do
            folder.category_id = nil
            expect(folder).not_to be_valid
            expect(folder.errors.messages[:category]).to include 'を入力してください'
        end
    end

    context '位置の存在性チェック' do
        it '位置が存在しない場合、無効であること' do
            folder.position = nil
            expect(folder).not_to be_valid
        end
    end

  end
end

