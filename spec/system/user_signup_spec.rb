require 'rails_helper'

RSpec.describe 'Sign up', type: :system do
  before do
    visit signup_path
  end

  context '有効なユーザー' do
    example '新規登録が成功すること', js: true do
      expect do
        fill_in '名前【必須】', with: 'test_name'
        fill_in 'メールアドレス【必須】', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認)', with: 'password'
        click_button '登録'
      end.to change(User, :count).by(1)
      expect(page).to have_content 'アカウント登録が完了しました。'
    end

    example '新規登録に失敗すること' do
      expect do
        fill_in '名前【必須】', with: ''
        fill_in 'メールアドレス【必須】', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認)', with: 'password'
        click_button '登録'
      end.not_to change(User, :count)
      expect(page).to have_content '名前が入力されていません。'
      expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
    end
  end
end
