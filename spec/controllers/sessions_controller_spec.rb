require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "bad information login" do
    let(:post_create){post(:create, params:{
      session:{
        email: "",
        password: "" }
    })}

    it 'flashの生存時間が正しい' do
      post_create
      expect(response).to render_template('sessions/new')
      expect(flash[:danger]).not_to be_empty
      get :new
      expect(flash[:danger]).to eq nil
    end
  end
end
