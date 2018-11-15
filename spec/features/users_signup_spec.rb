
describe 'user signup',type: :request do
  describe '登録失敗' do  
    let(:post_create){post( '/users', params: {
      user: attributes_for(:user,:invalid)
    })}

    it 'エラーを表示している' do
      get '/signup'
      post_create
      expect(response.body).to include('errors')
    end
  end
end