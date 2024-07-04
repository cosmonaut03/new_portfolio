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