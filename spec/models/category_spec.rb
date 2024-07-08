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
require 'rails_helper'
RSpec.describe Category, type: :model do

    describe 'カテゴリーのバリデーションテスト' do
        let(:user) { create(:user) }
        let(:category) { Category.new } 
    
        context '名前の存在性チェック' do
          it '名前が存在しない場合、無効であること' do
            category.name = nil
            expect(category).to_not be_valid
          end
        end
    
        context '位置の存在性チェック' do
          it '位置が存在しない場合、無効であること' do
            category.position = nil
            expect(category).to_not be_valid
          end
        end
    
        context 'is_uncategorizedの一意性チェック' do
          it '同じuser_idでis_uncategorizedがtrueのレコードが既に存在する場合、無効であること' do
            
            Category.create!(user_id: user.id, is_uncategorized: true, name: "test_category", position: 1)
            category.user_id = user.id
            category.is_uncategorized = true
            expect(category).to_not be_valid
          end
        end
    end
end