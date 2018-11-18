require 'rails_helper'

feature 'UsersEdit', type: :feature do

  describe 'edit' do
    let(:user){create(:user)}
    let(:login){login_in_capy(user)}
    let(:logout){logout_in_capy}
    describe 'friendly forwarding' do
      context 'after login' do
        scenario 'render desired page' do
          visit edit_user_path(user)
          expect(page).to have_css('div.alert.alert-danger',text: "Please log in")
          expect(page).to have_current_path(login_path)
          login
          expect(page).to have_current_path(edit_user_path(user))
        end
      end
    end
  end
end