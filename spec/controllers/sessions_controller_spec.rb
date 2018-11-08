require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "invalid information login(POST#create)" do
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

  describe 'valid login(POST#create)' do
    let(:user){create(:user)}
    let(:post_create){post(:create,params:{
      session:{
        email: user.email,
        password: user.password
      }
    })}

    it 'サインイン後リダイレクトする' do
      post_create
      created = User.find_by(email: user.email)
      expect(response).to redirect_to("/users/#{created.id}")
    end

    it 'ログインセッションが保存される' do
      post_create
      expect(is_logged_in?).to eq true
    end
  end

  describe 'POST#destroy' do
    let(:user){create(:user)}
    let(:post_create){post(:create,params:{
      session:{
        email: user.email,
        password: user.password
      }
    })}

    it 'ログインセッションが正常終了' do
      post_create
      delete :destroy
      expect(is_logged_in?).to eq false
    end

    it 'ルートページへリダイレクトする' do
      post_create
      delete :destroy
      binding.pry
      expect(response).to redirect_to(root_url)
    end
  end
end
