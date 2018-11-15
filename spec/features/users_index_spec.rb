require 'rails_helper'
require 'supports/login_helper.rb'

feature "UsersIndex", type: :feature do
  let(:users){create_list(:other_user,30)}
  let(:michael){create(:michael)}
  describe "index" do
    describe 'ページネーション' do
      before{users}
      scenario 'indexページに含まれている' do
        visit login_path
        login_in_capy(michael)
        click_on "Users"
        expect(page).to have_current_path("/users")
        expect(page).to have_css('div.pagination',count: 2)
        User.paginate(page: 1).each do |u|
          expect(page).to have_css("li",text: u.name)
        end
      end
    end
  end
end