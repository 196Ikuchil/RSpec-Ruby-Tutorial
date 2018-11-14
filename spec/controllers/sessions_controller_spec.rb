require 'rails_helper'
require 'supports/login_helper'
require 'logger' 


RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    context "when login with invalid parameters" do
      let(:post_create){post(:create, params:{
        session:{
          email: "",
          password: "" }
      })}

      it 'ログイン画面に戻される' do
        post_create
        expect(response).to render_template(:new)
      end

      it 'flashの生存時間が正しい' do
        post_create
        expect(response).to render_template('sessions/new')
        expect(flash[:danger]).not_to be_empty
        get :new
        expect(flash[:danger]).to eq nil
      end
    end

    context 'when login with valid parameters' do
      let(:user){create(:user)}
      let(:post_create){log_in_as(user,remember_me: '1')}
      let(:post_create_not_remember){log_in_as(user,remember_me: false)}
      it 'サインイン後リダイレクトする' do
        post_create
        created = User.find_by(email: user.email)
        expect(response).to redirect_to("/users/#{created.id}")
      end

      it 'ログインセッションが保存される' do
        post_create
        expect(is_logged_in?).to eq true
      end
      context 'when with remember_me' do
        it 'ログインcookieが保存される' do
          post_create
          expect(response.cookies['user_id']).to_not eq nil
        end

        it 'remember_tokenクッキーが保存される' do
          post_create
          expect(response.cookies['remember_token']).to_not eq nil 
        end

        it 'remember_token cookiesがuser内の物と同じ' do
          post_create
          expect(response.cookies['remember_token']).to eq assigns(:user).remember_token
        end
      end

      context 'when without remember_me' do
        it 'ログインcookieが保存されない' do
          post_create_not_remember
          expect(response.cookies['user_id']).to eq nil
        end

        it 'remember_tokenクッキーが保存されない' do
          post_create_not_remember
          expect(response.cookies['remember_token']).to eq nil
        end
      end
    end
  end

  describe '#destroy' do
    context "when logout succeed" do
      let(:user){create(:user)}
      let(:post_create){log_in_as(user,remember_me: true)}
      
      it 'ログインセッションが正常終了' do
        post_create
        delete :destroy
        expect(response.cookies[:user_id]).to eq nil
      end

      it 'ログインcookieが削除される' do
        post_create
        delete :destroy
        expect(is_logged_in?).to eq false
      end

      it 'remember_tokenクッキーが削除される' do
        post_create
        delete :destroy
        expect(response.cookies[:remember_token]).to eq nil
      end

      it 'ルートページへリダイレクトする' do
        post_create
        delete :destroy
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
