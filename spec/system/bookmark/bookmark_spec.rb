require 'rails_helper'

RSpec.describe 'ブックマーク - システムテスト', type: :system do
  include LoginMacros

  let!(:user) { create(:user) }
  let!(:home_layout) { create(:home_layout, :personal, user: user) } 
  let!(:category) { create(:category, :is_personal, user: user) }
  let!(:folder) { create(:folder, user: user, category: category) }
  let!(:new_category) { create(:category, user: user) }
  let!(:new_folder) { create(:folder, user: user, category: new_category) }
  let!(:new_bookmark) { create(:bookmark, user: user, category: new_category, folder: nil) }

  before {
     visit root_path 
     click_on(id: "head-login-link")
     login(user)
  }

  describe 'ブックマーク作成' do
    context '登録失敗' do
        before {
            # ブックマークモーダルを開く
            find("#add-btn-c#{category.id}").hover
            link = find("#new-link-c#{category.id}", visible: false)
            page.execute_script("arguments[0].click()", link)
        }

        it 'ブックマークURLが空の場合エラーメッセージが表示されること' do
            fill_in 'bookmark_url', with: ''
            fill_in 'bookmark_title', with: 'bookmark_test_title'
            fill_in 'bookmark_description', with: 'bookmark_test_description'
            click_on("modal-bookmark-btn")
            expect(page).to have_content('URLを入力してください'), 'フラッシュメッセージ「URLを入力してください」が表示されていません'
        end

        it 'ブックマーク名が空の場合エラーメッセージが表示されること' do
            fill_in 'bookmark_url', with: 'https://school.runteq.jp/v2/top'
            fill_in 'bookmark_title', with: ''
            fill_in 'bookmark_description', with: 'bookmark_test_description'
            click_on("modal-bookmark-btn")
            expect(page).to have_content('タイトルを入力してください'), 'フラッシュメッセージ「タイトルを入力してください」が表示されていません'
        end
    end

    context '登録成功 - フォルダなし' do
        before {
            # ブックマークモーダルを開く
            find("#add-btn-c#{category.id}").hover
            link = find("#new-link-c#{category.id}", visible: false)
            page.execute_script("arguments[0].click()", link)
        }
        it 'パラメータが正常な場合、ブックマークの登録が行えること' do
            fill_in 'bookmark_url', with: 'https://school.runteq.jp/v2/top'
            fill_in 'bookmark_title', with: 'test_title'
            fill_in 'bookmark_description', with: 'test_description'
            bookmark_title = 'test_title'
            bookmark_description = 'test_description'
            click_on("modal-bookmark-btn")
            sleep 1
            expect(page).to have_content(bookmark_title), "登録されたブックマークタイトル：「#{bookmark_title}」が表示されていません"
            expect(page).to have_content(bookmark_description), "登録されたブックマーク概要：「#{bookmark_description}」が表示されていません"
        end
    end

    context '登録成功 - フォルダ内' do
        before {
            # フォルダ内のブックマークモーダルを開く
            click_on("folder-panel-btn#{folder.id}")
            find("#add-btn-c#{category.id}-f#{folder.id}").hover
            link = find("#new-link-c#{category.id}-f#{folder.id}", visible: false)
            page.execute_script("arguments[0].click()", link)
        }
        it 'パラメータが正常な場合、ブックマークの登録が行えること' do
            fill_in 'bookmark_url', with: 'https://school.runteq.jp/v2/top'
            fill_in 'bookmark_title', with: 'title_folder'
            fill_in 'bookmark_description', with: 'with_folder'
            bookmark_title = 'title_folder'
            bookmark_description = 'with_folder'
            click_on("modal-bookmark-btn")
            sleep 1
            expect(page).to have_content(bookmark_title), "登録されたブックマークタイトル：「#{bookmark_title}」が表示されていません"
            expect(page).to have_content(bookmark_description), "登録されたブックマーク概要：「#{bookmark_description}」が表示されていません"
        end
    end
  end

  describe 'URLの動作チェック' do
    it '別ウィンドウで画面が開かれること' do   
        switch_to_window(windows.last)

        # ウィンドウが開かれることを確認
        click_on("bookmark-url-#{new_bookmark.id}")

        switch_to_window(windows.last)
        expect(page).to have_current_path(new_bookmark.url, url: true)
      end
  end

  describe 'ブックマーク修正' do
    context '表示・登録' do
        it 'ブックマークの修正が行えること' do
            click_on("edit-bookmark-#{new_bookmark.id}")
            expect(find_field('bookmark_url').value).to eq(new_bookmark.url), '登録されたブックマークURLが表示さていません'
            expect(find_field('bookmark_title').value).to eq(new_bookmark.title), '登録されたブックマークタイトルが表示さていません'
            expect(find_field('bookmark_description').value).to eq(new_bookmark.description), '登録されたブックマーク概要が表示さていません'
            fill_in 'bookmark_url', with: "https://copilot.microsoft.com/" 
            fill_in 'bookmark_title', with: "update_bookmark" 
            fill_in 'bookmark_description', with: 'bookmark_update'
            click_on("modal-bookmark-btn")

            sleep 1
            expect(page).to have_content("update_bookmark"), "登録されたブックマークタイトル:「update_bookmark」が表示されていません"
            expect(page).to have_content("bookmark_update"), "登録されたブックマーク概要:「bookmark_update」が表示されていません"
        end
    end
  end

  describe 'ブックマーク削除' do
    context '正常系' do
        xit 'ブックマークが削除されること' do
            title = new_bookmark.title
            click_on("delete-bookmark-#{new_bookmark.id}")
            # アラートを受け入れる
            page.accept_alert('ブックマークを削除しますか？')

            sleep 1
            expect(Bookmark.exists?(new_bookmark.id)).to be_falsey, 'ブックマークが削除されていません(DB)'
            expect(page).not_to have_content(title), 'ブックマークが削除されていません(View)'
        end
    end
  end
end