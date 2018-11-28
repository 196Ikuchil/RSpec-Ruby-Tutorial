require 'rails_helper'
require 'supports/login_helper.rb'

feature "UsersIndex", type: :feature do
  let(:not_activated_user){create(:user,:not_activated)}
  let(:users){create_list(:other_user,40)}
  let(:michael){create(:user,:michael)}
  describe "index" do
    describe 'ページネーション' do
      before{
        michael
        not_activated_user
        users
        
      }
      scenario 'indexページに含まれている' do
        visit login_path
        login_in_capy(michael)
        click_on "Users"
        expect(page).to have_current_path("/users")
        expect(page).to have_css('div.pagination',count: 2)
        User.paginate_filter(page: 1).each do |u|
          expect(page).to have_css("li",text: u.name)
        end
      end
    end
  end
end