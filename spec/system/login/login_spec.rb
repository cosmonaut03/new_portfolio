require 'rails_helper'

RSpec.describe 'ログイン・ログアウト', type: :system do
  include LoginMacros
  before { visit root_path }
  let(:user) { create(:user) }

  describe '通常画面' do
    describe 'ログイン' do
      context '認証情報が正しい場合' do
        it 'ログインできること' do
          click_on(id: "head-login-link")
          login(user)
          # Capybara.assert_current_path(root_path, ignore_query: true)
          # expect(current_path).to eq root_path, "パスが異なります：#{current_path}"
          expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
        end
      end

      context 'メールアドレスが空の場合' do
        it 'ログインできないこと' do
          click_on(id: "head-login-link")
          user.email = ''
          login(user)
          # Capybara.assert_current_path(root_path, ignore_query: true)
          # expect(current_path).to eq root_path, "パスが異なります：#{current_path}"
          expect(page).to have_content('メールアドレスまたはパスワードが無効です'), 'フラッシュメッセージ「メールアドレスまたはパスワードが無効です」が表示されていません'
        end
      end
    end

    describe 'ログアウト' do
      before do
        click_on(id: "head-login-link")
        login(user)
      end
      it 'ログアウトできること' do
        find('#header-profile').click
        click_on('ログアウト')
        # Capybara.assert_current_path("/", ignore_query: true)
        # expect(current_path).to eq root_path
        expect(page).to have_content('ログアウトしました'), 'フラッシュメッセージ「ログアウトしました」が表示されていません'
      end
    end
  end
end
