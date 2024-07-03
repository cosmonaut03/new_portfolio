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
require 'rails_helper'
RSpec.describe HomeLayout, type: :model do

    describe 'ホームレイアウトのバリデーションテスト' do
        context 'デフォルト値チェック' do
            it 'ホーム画面フラグ初期値' do
                home_layout = HomeLayout.new
                expect(home_layout.is_personal).to eq(false)
            end

            it '表示・非表示フラグ初期値' do
                home_layout = HomeLayout.new
                expect(home_layout.is_visible).to eq(true)
            end
        end
    end
end