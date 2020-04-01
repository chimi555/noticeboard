require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  
  describe "ユーザー一覧ページ" do
    context '管理ユーザー' do
      before do
        sign_in admin_user
        visit users_path
      end

      example 'deleteリンクが表示されること' do
        expect(page).to have_link "delete"
      end

      example 'ユーザーを削除できること', js: true do
        click_on "delete"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_current_path users_path
        expect(page).to have_content "ユーザーを削除しました"
      end
    end
  end
end

