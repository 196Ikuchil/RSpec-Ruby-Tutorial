require 'rails_helper'
require 'spec_helper'

describe 'Users Signup page', type: :request do
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