require 'rails_helper'

describe 'SessionsHelper' do
  include SessionsHelper

  let(:user){create(:user)}
  describe 'remember' do
    context 'when session is nil' do
      it 'current_user returns correct user' do 
        remember(user)
        expect(current_user).to eq user
      end
    end

    context 'when remember digest is wrong' do
      it 'current_user returns nil ' do
        remember(user)
        user.update_attribute(:remember_digest,User.digest(User.new_token))
        expect(current_user).to eq nil
      end
    end
  end
end