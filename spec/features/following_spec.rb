require 'rails_helper'
require 'supports/login_helper'

feature 'followingTest', type: :feature do
  let(:user){create(:user)}
  let(:michael){create(:user,:michael)}
  let(:users){create_list(:other_user,40)}


  before{
    users
    users.each do |u|
      user.follow(u)
      u.follow(user)
    end
    user.follow(michael)
    michael.follow(user)
    visit login_path
    login_in_capy(user)
  }
  it 'user following 41 user' do
    expect(user.following.count).to eq 41
  end
  it 'user followed by 41 user' do
    expect(user.followers.count).to eq 41
  end
  it 'michael followed 1 user'do
    expect(michael.followers.count).to eq 1
  end


  context 'following page' do
    scenario 'pagination' do
      click_link "following"
      user.following.paginate(page: 1).each do |u|
        expect(page).to have_css('li',text: u.name)
        expect(page).to have_link(u.name,href: user_path(u))
      end
    end
  end

  context 'followers page' do
    scenario 'pagination' do
      click_link 'followers'
      user.followers.paginate(page: 1).each do |u|
        expect(page).to have_css('li',text: u.name)
        expect(page).to have_link(u.name,href: user_path(u))
      end
    end
  end
end