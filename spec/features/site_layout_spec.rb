require 'rails_helper'

feature 'Site Layout',type: :feature do

  describe 'layout links' do
    scenario '常に表示されている' do
      visit root_path
      link = find('a',text: 'sample app')
      expect(link[:href]).to eq root_path
      link = find('a', text: 'Home')
      expect(link[:href]).to eq root_path
      link = find('a', text: 'Help')
      expect(link[:href]).to eq help_path
      link = find('a', text: 'About')
      expect(link[:href]).to eq about_path
      link = find('a', text: 'Contact')
      expect(link[:href]).to eq contact_path
      link = find('a',text: 'News')
      expect(link[:href]).to eq "http://news.railstutorial.org/"
    end

    context 'when not logged in' do
      scenario 'ログインリンクのみ表示される' do
        visit login_path
        link = find('a',text: 'Log in')
        expect(link[:href]).to eq login_path
      end
    end

    context 'when logged in' do
      let(:user){create(:user)}
      scenario 'ログインユーザ用のリンクが表示される' do
        visit login_path
        login_in_capy(user)
        link = find('a',text: 'Profile')
        expect(link[:href]).to eq user_path(user)
        link = find('a',text: 'Settings')
        expect(link[:href]).to eq edit_user_path(user)
        link = find('a',text: 'Log out')
        expect(link[:href]).to eq logout_path
      end
    end
  end
end