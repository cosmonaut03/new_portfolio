require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  before { visit root_path }

  context 'トップページの画面表示' do
    it '正しいタイトルが表示されていること' do
      expect(page).to have_title("My Dash"), 'ユーザー登録ページのタイトルに「My Dash」が含まれていません。'
    end
  end

  context '入力情報正常系' do
    it 'ユーザーが新規作成できること' do
      click_on(id: "head-new-link")
      expect {
        fill_in 'メールアドレス', with: 'example@example.com'
        fill_in 'パスワード', with: '12345678'
        click_on(id: "modal-new-btn")
        # または、特定の要素が表示されるまで待機
        expect(page).to have_text('登録が完了しました'), 'フラッシュメッセージ「登録が完了しました」が表示されていません'
      }.to change { User.count }.by(1)
    end
  end

  context '入力情報異常系' do
    it 'ユーザーが新規作成できない: パスワードエラー' do
      click_on(id: "head-new-link")
      expect {
        fill_in 'メールアドレス', with: 'example@example.com'
        click_on(id: "modal-new-btn")
      }.to change { User.count }.by(0)
      expect(page).to have_content('パスワードを入力してください'), 'エラーメッセージ「パスワードを入力してください」が表示されていません'
      expect(page).to have_content('パスワードは3文字以上で入力してください'), 'フラッシュメッセージ「パスワードは3文字以上で入力してください」が表示されていません'
    end

    it 'ユーザーが新規作成できない: メールアドレス' do
      click_on(id: "head-new-link")
      user = create(:user)
      expect {
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: '123456'
        click_on(id: "modal-new-btn")
      }.to change { User.count }.by(0)
      expect(page).to have_content('メールアドレスはすでに存在します'), 'エラーメッセージ「メールアドレスはすでに存在します」が表示されていません'
    end
  end

  context '画面切り替え' do
    it 'ログインウィンドウ表示' do
      click_on(id: "head-new-link")
      click_on(id: "modal-login-link")
      expect(page).to have_content('初めての利用の方は'), 'ログイン画面が表示されていません'
    end
  end

end
