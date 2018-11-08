require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'success signup (POST#create)' do
    let(:user){build(:user)}
    let(:post_create){
      post( :create, params: {
        user: {
          name:   user.name,
          email:  user.email,
          password: user.password,
          password_confirmation: user.password_confirmation 
        }
    })}

    it 'ユーザが新規に生成される' do
      expect{post_create}.to change{User.count}.by(1)
    end

    it 'サインアップ後リダイレクトする' do
      post_create
      created = User.find_by(email: user.email)
      expect(response).to redirect_to("/users/#{created.id}")
    end

    it 'flashに値が入っている' do
      post_create
      created = User.find_by(email: user.email)
      get :show, params: {id: created.id} 
      expect(flash[:success]).not_to be_empty
    end

    it 'flashの値が消える' do
      post_create
      created = User.find_by(email: user.email)
      get :show, params: {id: created.id}
      get :show, params: {id: created.id}
      expect(flash[:success]).to be nil
    end
  end

  describe 'invalid signup information (POST#create)' do
    let(:post_create){post( :create, params: {
      user: {
        name:   "",
        email:  "",
        password: "notpas",
        password_confirmation: "notpass" }
    })}

    it 'ユーザ数が増えない' do
      expect{post_create}.to_not change{User.count}
    end

    it 'users/newに遷移する' do
      post_create
      expect(response).to render_template('users/new')
    end
  end
end
