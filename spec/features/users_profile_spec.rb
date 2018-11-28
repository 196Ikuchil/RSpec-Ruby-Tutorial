require 'rails_helper'
require 'supports/login_helper'

feature "UserProfileTest", type: :feature do
  let(:user){create(:user)}
  let(:user_post){create_list(:micropost,40,user:user)}
  describe 'profile' do
    before{
      visit login_path
      login_in_capy(user)
      user_post
    }
    scenario 'correct current_path' do
      visit user_path(user)
      expect(current_path).to eq user_path(user)
    end

    scenario 'have title and user info' do
      visit user_path(user)
      expect(page).to have_title(user.name)
      expect(page).to have_selector('h1',text: user.name)
      expect(page).to have_css('img.gravatar')
    end

    scenario 'personal microposts count' do
      visit user_path(user)
      expect(user.microposts.count).to eq user_post.count
    end

    scenario 'rendered microposts by paginate' do
      visit user_path(user)
      expect(page).to have_css('div.pagination')
      user.microposts.paginate(page: 1).each do |micropost|
        expect(page).to have_css("li#micropost-#{micropost.id}",text: micropost.content)
      end
    end
  end
end
