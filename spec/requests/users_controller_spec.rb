require 'rails_helper'
require 'supports/login_helper'

RSpec.describe UsersController, type: :request do

  describe '#index' do
    context 'visit index' do
      let(:user){create(:user)}
      it 'indexページが描画される' do
        login_in_request(user,remember_me:true)
        get users_path
        expect(response).to render_template('users/index')
      end
    end 
    context 'when not logged in' do
      it 'ログインページにリダイレクトされる' do
        get users_path
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'show' do
    context 'when logged in user access' do
      let(:user){create(:user)}
      it '正常なページが表示される' do
        get user_path(user)
        expect(response).to render_template('users/show')
      end
    end

    context 'when access not activated user page' do
      let(:user){create(:user,:not_activated)}
      it 'ルートページに戻される' do
        get user_path(user)
        expect(response).to redirect_to(root_path)
      end
    end
  end
  


  describe 'create' do
    context 'when success signup' do
      let(:user){build(:user)}
      let(:post_create){
        post( signup_path, params: {
          user: attributes_for(:user)
      })}

      it 'ユーザが新規に生成される' do
        expect{post_create}.to change{User.count}.by(1)
      end

      it 'サインアップ後リダイレクトする' do
        post_create
        expect(response).to redirect_to(root_url)
      end

      it 'flashに値が入っている' do
        post_create
        get root_url
        expect(flash[:info]).not_to be_empty
      end

      it 'flashの値が消える' do
        post_create
        get root_url
        get root_url
        expect(flash[:info]).to eq nil
      end
    end
    context 'invalid signup information' do
      let(:post_create){post( users_path, params: {
        user: attributes_for(:user, :invalid)
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

  describe 'edit' do
    let(:user){create(:user)}
    let(:get_edit){get edit_user_path(user)}
    let(:login){login_in_request(user)}
    context 'when visit edit page' do
      it 'render edit page' do
        login
        get_edit
        expect(response).to render_template('users/edit')
      end
    end

    context 'when not logged in' do 
      it '権限がなくログインページに飛ばされる' do
        get_edit
        expect(response).to redirect_to(login_url)
      end
      it 'フラッシュに値が入る' do
        get_edit
        expect(flash[:danger]).to_not be_empty
      end
      it 'sessionにurlが保存される' do
        get_edit
        expect(session[:forwarding_url]).to eq edit_user_url(user)
      end
    end
  end

  describe '#update' do
    let(:user){create(:user)}
    let(:login){login_in_request(user)}
    let(:update_user){patch( user_path(user), params:{
      user: attributes_for(:user,:michael)
    })}
    context 'when use valid info' do
      it 'flashが空でない' do 
        login
        update_user
        expect(flash[:success]).to_not be_empty
      end

      it 'プロフィールページにリダイレクト' do
        login
        update_user
        expect(response).to redirect_to(user)
      end

      it 'user情報が変更される' do
        login
        expect{update_user}.to change{User.find(user.id).name}.from(user.name).to(build(:user,:michael).name)
      end
    end

    context 'when use invalid info' do
      it 'editに戻ってくる' do
        login
        get edit_user_path(user)
        patch( user_path ,params:{
          id: user.id,
          user: attributes_for(:user,:invalid)
          })
        expect(response).to render_template('users/edit')
      end
    end

    context 'when try to edit admin attr' do
      let(:michael){create(:user,:michael)}
      let(:update_admin){patch(user_path(michael), params:{
        user: {
          password: michael.password,
          password_confirmation: michael.password,
          admin: true
        }
      })}
      it 'not change' do
        login
        expect{update_admin}.to_not change{User.find(michael.id).admin}
      end
    end

    context 'when not logged in' do 
      it '権限がなくログインページに飛ばされる' do
        update_user
        expect(response).to redirect_to(login_url)
      end
      it 'フラッシュに値が入る' do
        update_user
        expect(flash[:danger]).to_not be_empty
      end
    end
  end

  describe '#destroy' do
    let(:michael){create(:user,:michael)}
    let(:archer){create(:user,:archer)}
    let(:user){create(:user)}
    let(:delete_destroy){delete user_path(user)}
    before{ 
      michael
      archer
      user
    }

    context 'when not logged in' do
      it 'ログインページへ飛ばされる' do
        delete_destroy
        expect(response).to redirect_to(login_path)
      end

      it 'ユーザは削除されない' do
        expect{delete_destroy}.to_not change{User.count}
      end

    end
    context 'when not admin user' do 
      it 'ルートページへ飛ばされる' do
        login_in_request(archer)
        delete_destroy
        expect(response).to redirect_to(root_path)
      end
      it 'ユーザは削除されない' do
        login_in_request(archer)
        expect{delete_destroy}.to_not change{User.count}
      end
    end
    context 'when admin user' do
      it 'ユーザは削除される' do
        login_in_request(michael)
        expect{delete_destroy}.to change{User.count}.from(User.count).to(User.count-1)
      end
    end
  end
end