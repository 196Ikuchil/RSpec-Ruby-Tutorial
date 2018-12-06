require 'rails_helper'
require 'supports/login_helper'

RSpec.describe MicropostsController , type: :request do
  describe 'create' do
    context 'when not logged in' do
      let(:post_create){post(microposts_path,params:{micropost:{content: "Content"}})}
      it 'not increase micropost' do
        expect{post_create}.to_not change{Micropost.count}
      end

      it 'redirect to login page' do
        post_create
        expect(response).to redirect_to(login_path)
      end
    end
  end
  describe 'destroy' do
    let(:user){create(:user)}
    let(:other_user){create(:other_user)}
    let(:micropost){create(:micropost,user: user)}
    let(:other_micropost){create(:other_micropost,user:other_user)}
    let(:delete_destroy){delete(micropost_path(micropost))}
    context 'when not logged in' do
      before{ micropost }
      it 'not decrease micropost' do
        expect{delete_destroy}.to_not change{Micropost.count}
      end
      it 'redirect to login page' do
        delete_destroy
        expect(response).to redirect_to(login_path)
      end
    end


    context 'when delete other users micropost' do
      it 'redirect to root_url' do
        login_in_request(other_user,remember_me:true)
        micropost
        expect{delete_destroy}.to_not change{Micropost.count}
      end
    end
  end
end