require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do

  describe "edit" do
    let(:user){create(:user,:not_activated)}
    before{
      user
      user.activation_token = User.new_token
      user.update_attribute(:activation_digest,User.digest(user.activation_token))
    }
    context 'when correct activation' do
      before{get :edit,params:{id:user.activation_token,email: user.email}}
      it '有効される' do
        expect(user.reload.activated?).to eq true
      end
      it 'ログインできる' do
        expect(is_logged_in?).to eq true
      end
    end

    context 'when use invalid activation token' do
      before{get :edit,params:{id:"invalid token",email: user.email}}
      it '有効化されない' do
        expect(user.reload.activated?).to eq false
      end
      it 'ログインできない' do
        expect(is_logged_in?).to eq false
      end
    end

    context 'when use invalid email' do
      before{get :edit,params:{id:user.activation_token,email: "wrong@email.com"}}
      it '有効化されない' do
        expect(user.reload.activated?).to eq false
      end
      it 'ログインできない' do
        expect(is_logged_in?).to eq false
      end
    end
  end
end
