require 'rails_helper'

RSpec.describe 'Session', type: :system do
  let!(:user) { create(:user) }

  describe "ログイン" do
    before do
      visit login_path
    end

    context '入力値が正しいとき' do
      example 'ログインに成功すること', js: true do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        expect(page).to have_current_path user_path(user.id)
        expect(page).to have_content 'ログインしました。'
      end
    end

    context '入力値が正しくないとき' do
      example 'ログインに失敗すること' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
  end

  describe "ログアウト" do
    before do
      sign_in user
      visit root_path
    end

    example 'ログアウトに成功すること' do
      within(".navbar") do
        click_on 'ログアウト'
      end
      expect(page).to have_content 'ログアウトしました。'
    end
  end
end
