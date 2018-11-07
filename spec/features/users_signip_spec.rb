require 'rails_helper'
require 'spec_helper'

describe 'Users Signup page', type: :request do
  describe 'success signup' do
    it 'ユーザの登録に成功する' do
      get '/signup'
      expect do
        user = build(:user)
        post '/users', params: {
          user: {
            name:   user.name,
            email:  user.email,
            password: user.password,
            password: user.password_confirmation 
        }
      }
      end.to change{User.count}
    end

    it 'リダイレクトする' do
      get '/signup'
      user = build(:user)
      post '/users', params: {
        user: {
          name:   user.name,
          email:  user.email,
          password: user.password,
          password: user.password_confirmation 
        }
      }
      created = User.find_by(email: user.email)
      expect(response).to redirect_to("/users/#{created.id}")
    end

    it 'flushに値が入っている' do
      get '/signup'
      user = build(:user)
      post '/users', params: {
        user: {
          name:   user.name,
          email:  user.email,
          password: user.password,
          password: user.password_confirmation 
        }
      }
      expect(flash[:success]).not_to be_empty
    end
  end

  describe 'invalid signup information' do
    it 'ユーザ数が増えない' do
      get '/signup'
      expect do
        post '/users', params: {
          user: {
            name:   "",
            email:  "",
            password: "notpas",
            password: "notpass" 
        }
      }
      end.to_not change{User.count}
    end

    it 'エラーを保持しusers/newに遷移する' do
      get '/signup'
      post '/users', params: {
        user: {
          name:   "",
          email:  "",
          password: "notpas",
          password: "notpass" 
        }
      }
      expect(response).to render_template('users/new')
      expect(response.body).to include('errors')
    end
  end
end