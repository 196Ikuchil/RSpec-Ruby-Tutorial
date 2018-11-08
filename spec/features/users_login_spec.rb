require 'rails_helper'

feature "UserLogin",type: :feature do
  def fill_in_login_form(user, option = { invalid: false })
    if option[:invalid]
      fill_in "Email",        with: ""
      fill_in "Password",     with: ""
    else
      fill_in "Email",        with: user.email
      fill_in "Password",     with: user.password
    end
  end

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
