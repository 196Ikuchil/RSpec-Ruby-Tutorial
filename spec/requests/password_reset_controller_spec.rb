require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'new' do
    context 'when access' do
      it 'リクエストの成功 ' do
        get new_password_reset_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'create' do
    let(:post_create){post(password_resets_path,params:{password_reset:{email:user.email}})}
    let(:user){create(:user)}

    context 'when valid email' do
      it 'reset_digestの値が変わる' do
        post_create
        expect(user.reset_digest).to_not eq user.reload.reset_digest 
      end

      it 'メールが送信される' do
        expect{post_create}.to change{ActionMailer::Base.deliveries.size}.from(0).to(1)
      end

      it 'flashに値が入る' do
        post_create
        expect(flash[:info]).to_not eq nil
      end

      it 'ルートにリダイレクトする' do
        post_create
        expect(response).to redirect_to(root_url)
      end
    end
    
    context 'when invalid email' do
      before{
        user.email="invalid@com"
        post_create
      }
      it 'flashに値が入る' do
        expect(flash[:danger]).to_not eq nil
      end
    end
  end

  describe 'edit' do
    let(:get_edit){get(edit_password_reset_path(user.reset_token,email: user.email))}
    let(:user){create(:user)}

    before{
      user
      user.reset_token = User.new_token
      user.update_attribute(:reset_digest,User.digest(user.reset_token))
      user.update_attribute(:reset_sent_at,Time.zone.now)
    }
    context 'when use vaild url' do
      it 'editページに飛ぶ' do
        get_edit
        expect(response.status).to eq 200
      end
    end

    context 'when invalid email' do
      it 'ルートにリダイレクトする' do
        user.email="invalid@com"
        get_edit
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when invalid token' do
      it 'ルートにリダイレクトする' do
        user.reset_token = User.new_token
        get_edit
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when invalid user' do
      it 'ルートにリダイレクトする' do
        user.toggle!(:activated)
        get_edit
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when reset_sent_at expire' do
      before{user.update_attribute(:reset_sent_at,3.hours.ago)}
      it 'flashに値が入る' do
        get_edit
        expect(flash[:danger]).to_not eq nil
      end

      it 'newページへリダイレクトする' do
        get_edit
        expect(response).to redirect_to("/password_resets/new")
      end
    end
  end

  describe 'patch' do
    let(:user){create(:user)}
    context 'when use valid password' do
      let(:patch_update){patch(password_reset_path(user.reset_token),
        params:{
          email: user.email,
          user: {
            password: "foobaz",
            password_confirmation: "foobaz"
          }
        })
      }
      
      before{
        user
        user.reset_token = User.new_token
        user.update_attribute(:reset_digest,User.digest(user.reset_token))
        user.update_attribute(:reset_sent_at,Time.zone.now)
      }
      it 'flashに値が入る' do
        patch_update
        expect(flash[:success]).to_not eq nil
      end

      it 'showページへリダイレクトする' do
        patch_update
        expect(response).to redirect_to(user_url(user))
      end

      it 'ログインされる' do
        patch_update
        expect(is_logged_in?).to eq true
      end

      it 'reset_digestの値が消える' do
        patch_update
        expect(user.reload.reset_digest).to eq nil
      end
    end

    context 'when use invalid password' do
      let(:patch_update){patch(password_reset_path(user.reset_token),
        params:{
          email: user.email,
          user: {
            password: "foobar",
            password_confirmation: "foobaz"
          }
        })}
      it 'エラーが表示される' do
        expect(user.errors[:password]).to_not eq nil 
      end
    end

    context 'when use blank password' do
      let(:patch_update){patch(password_reset_path(user.reset_token),
        params:{
          email: user.email,
          user: {
            password: "",
            password_confirmation: ""
            }
        })}
      it 'エラーが表示される' do
      end
    end
  end
end