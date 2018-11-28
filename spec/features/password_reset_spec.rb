require 'rails_helper'
require 'supports/password_reset_helper'

feature 'PasswordReset', type: :feature do
  before{ActionMailer::Base.deliveries.clear}

  context 'when success reset password' do

    scenario 'パスワードリセットまでのシミュレート' do
      user = create(:user)
      visit new_password_reset_path
      expect(page).to have_title("Forgot password | Ruby on Rails Tutorial Sample App",exact:true)
      expect{reset_form(user.email)}.to change{ActionMailer::Base.deliveries.size}.from(0).to(1)
      expect(current_url).to eq(root_url)

      reset_url = expect(ActionMailer:: Base.deliveries.last.body.encoded).to match("^http.*?#{CGI.escape(user.email)}")
      user =User.find_by(email: user.email)
      visit reset_url
      expect(page).to have_title("Reset password | Ruby on Rails Tutorial Sample App",exact:true)
      expect(find('#email',visible:false).value).to eq user.email
      fill_in "password" , with: "foobaz"
      fill_in "password_confirmation", with: "foobaz"
      click_on "Update password"
      expect(current_path).to eq user_path(user.reload)
    end
  end
end