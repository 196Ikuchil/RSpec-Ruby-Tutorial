require 'rails_helper'

feature "UserLogin",type: :feature do

  let(:user){create(:user)}
  
  describe "log in" do
    scenario "ログイン成功" do
      visit '/login'
      fill_in_login_form(user)
      click_button "Log in"
      expect(page).to have_current_path(user_path(user))
      link= find('a', text: 'Log out')
      expect(link[:href]).to eq logout_path
    end
  end

    scenario "ログイン失敗" do
      visit '/login'
      fill_in_login_form(user,invalid: true)
      click_button "Log in"
      expect(page).to have_current_path("/login")
    end
end
