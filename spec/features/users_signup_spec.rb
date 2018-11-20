require 'supports/signup_helper.rb'
require 'spec_helper'
require 'rails_helper'

feature 'user signup',type: :feature do
  before{ActionMailer::Base.deliveries.clear}
  context '登録失敗時' do  
    let(:user){build(:user,:invalid)}

    scenario 'エラーを表示している' do
      visit signup_url
      signup(user)
      expect(page).to have_css('div.alert')
    end

  end

  context 'when succeed signup with account activation' do

    scenario 'サインアップ完了までの道のり' do
      visit signup_url
      user = build(:user,:not_activated)
      expect{signup(user)}.to change{User.count}.by(1)
      expect(ActionMailer::Base.deliveries.size).to eq 1
      activation_url = expect(ActionMailer:: Base.deliveries.last.body.encoded).to match("^http.*?#{CGI.escape(user.email)}")
      user =User.find_by(email: user.email)
      visit activation_url
      expect(current_path).to eq user_path(user)
      user =User.find_by(email: user.email)
      expect(user.activated?).to eq true
      expect(page).to have_content('Log out', minimum: 1)
    end
  end
end