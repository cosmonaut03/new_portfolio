# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  avatar           :string
#  crypted_password :string
#  email            :string           not null
#  name             :string
#  salt             :string
#  user_name        :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
    describe "ユーザモデルの動作確認" do
        context "バリデーション" do
            it 'emailがあり、パスワードは3文字以上であれば有効であること' do
              user = build(:user)
              expect(user).to be_valid
            end
          
            it 'メールはユニークであること' do
              user1 = create(:user)
              user2 = build(:user)
              user2.email = user1.email
              user2.valid?
              expect(user2.errors[:email]).to include('はすでに存在します')
            end
          
            it 'メールアドレス、パスワードは必須項目であること' do
              user = build(:user)
              user.email = nil
              user.password = nil
              user.valid?
              expect(user.errors[:email]).to include('を入力してください')
              expect(user.errors[:password]).to include('を入力してください')
            end
          
            it 'ユーザー名は255文字以下であること' do
              user = build(:user)
              user.user_name = 'a' * 256
              user.valid?
              expect(user.errors[:user_name]).to include('は255文字以内で入力してください')

            end
        end
    end
end
