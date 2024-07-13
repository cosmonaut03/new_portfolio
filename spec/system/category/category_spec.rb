require 'rails_helper'

RSpec.describe 'カテゴリ-システムテスト', type: :system do
  include LoginMacros

  let!(:user) { create(:user) }
  let!(:home_layout) { create(:home_layout, :personal, user: user) } 
  let!(:category) { create(:category, :is_personal, user: user) }
  let!(:new_category) { create(:category, user: user) }

  before {
     visit root_path 
     click_on(id: "head-login-link")
     login(user)
  }

  describe 'カテゴリ作成' do
    context '登録失敗' do
        it 'カテゴリ名が空の場合エラーメッセージが表示されること' do
            click_on("group-category-add-#{home_layout.id}")
            fill_in 'category_name', with: ''
            fill_in 'category_description', with: 'test_description'
            click_on("modal-category-btn")
            expect(page).to have_content('カテゴリ名を入力してください'), 'フラッシュメッセージ「カテゴリ名を入力してください」が表示されていません'
        end

    end

    context '登録成功' do
        it 'パラメータが正常な場合、カテゴリの登録が行えること' do
            click_on("group-category-add-#{home_layout.id}")
            category_name = 'test_category'
            fill_in 'category_name', with: category_name
            fill_in 'category_description', with: 'test_description'
            click_on("modal-category-btn")
            expect(page).to have_content(category_name), "登録されたカテゴリ名：「#{category_name}」が表示されていません"
        end
    end
  end

  describe 'カテゴリ修正' do
    context '表示・登録' do
        it 'カテゴリの修正が行えること' do
            click_on("edit-category-#{new_category.id}")
            expect(find_field('category_name').value).to eq(new_category.name), '登録されたカテゴリ名が表示さていません'
            expect(find_field('category_description').value).to eq(new_category.description), '登録された概要が表示さていません'
            fill_in 'category_name', with: "" 
            fill_in 'category_name', with: "update_category" 
            fill_in 'category_description', with: 'test_description_update'
            click_on("modal-category-btn")
            expect(page).to have_content("update_category"), "登録されたカテゴリ名:「update_category」が表示されていません"
        end
    end
  end

  describe 'カテゴリ削除' do
    context '正常系' do
        it 'カテゴリが削除されること' do
            title = new_category.name
            click_on("delete-category-#{new_category.id}")
            # アラートを受け入れる
            page.accept_alert('カテゴリを削除しますか？')

            sleep 1
            expect(Category.exists?(new_category.id)).to be_falsey, 'カテゴリが削除されていません(DB)'
            expect(page).not_to have_content(title), 'カテゴリが削除されていません(View)'
        end
    end

    context 'フォルダ、ブックマーク内包' do
        it 'カテゴリ、フォルダ、ブックマークが削除できること。' do

        end
    end
  end

end