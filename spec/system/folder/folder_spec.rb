require 'rails_helper'

RSpec.describe 'フォルダ - システムテスト', type: :system do
  include LoginMacros

  let!(:user) { create(:user) }
  let!(:home_layout) { create(:home_layout, :personal, user: user) } 
  let!(:category) { create(:category, :is_personal, user: user) }
  let!(:new_category) { create(:category, user: user) }
  let!(:new_folder) { create(:folder, user: user, category: new_category) }

  before {
     visit root_path 
     click_on(id: "head-login-link")
     login(user)
  }

  describe 'フォルダ作成' do
    context '登録失敗' do
        it 'フォルダ名が空の場合エラーメッセージが表示されること' do
            # tooltip-containerにhover
            find("#add-btn-c#{category.id}").hover
            # リンクをクリック
            link = find("#new-folder-#{category.id}", visible: false)
            page.execute_script("arguments[0].click()", link)
            fill_in 'folder_name', with: ''
            fill_in 'folder_description', with: 'folder_test_description'
            click_on("modal-folder-btn")
            expect(page).to have_content('フォルダ名を入力してください'), 'フラッシュメッセージ「フォルダ名を入力してください」が表示されていません'
        end
    end

    context '登録成功' do
        it 'パラメータが正常な場合、フォルダの登録が行えること' do
            # tooltip-containerにhover
            find("#add-btn-c#{category.id}").hover
            # リンクをクリック
            link = find("#new-folder-#{category.id}", visible: false)
            page.execute_script("arguments[0].click()", link)
            folder_name = 'test_folder'
            fill_in 'folder_name', with: folder_name
            fill_in 'folder_description', with: 'test_description'
            click_on("modal-folder-btn")
            sleep 1
            expect(page).to have_content(folder_name), "登録されたフォルダ名：「#{folder_name}」が表示されていません"
        end
    end
  end

  describe 'フォルダ修正' do
    context '表示・登録' do
        it 'フォルダの修正が行えること' do
            click_on("edit-folder-#{new_folder.id}")
            expect(find_field('folder_name').value).to eq(new_folder.name), '登録されたフォルダ名が表示さていません'
            expect(find_field('folder_description').value).to eq(new_folder.description), '登録された概要が表示さていません'
            fill_in 'folder_name', with: "" 
            fill_in 'folder_name', with: "update_folder" 
            fill_in 'folder_description', with: 'test_folder_update'
            click_on("modal-folder-btn")

            sleep 1
            expect(page).to have_content("update_folder"), "登録されたフォルダ名:「update_folder」が表示されていません"
        end
    end
  end

    describe 'フォルダ削除' do
        context '正常系' do
            it 'フォルダが削除されること' do
                title = new_folder.name
                click_on("delete-folder-#{new_folder.id}")
                # アラートを受け入れる
                page.accept_alert('フォルダを削除しますか？')
    
                sleep 1
                expect(Folder.exists?(new_folder.id)).to be_falsey, 'フォルダが削除されていません(DB)'
                expect(page).not_to have_content(title), 'フォルダが削除されていません(View)'
            end
        end
    
        context 'ブックマーク内包' do
            it 'フォルダ、ブックマークが削除できること。' do
    
            end
        end
    end
end