require 'rails_helper'

feature "UserLogout",type: :feature do
  let(:user){create(:user)}

  scenario 'ログイン状態からログアウト成功' do
    visit '/login'
    fill_in_login_form(user)
    click_button "Log in"
    expect(page).to have_current_path(user_path(user))
    click_link "Log out"
    expect(page).to have_current_path(root_path)
  end

end