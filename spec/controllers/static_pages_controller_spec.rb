require 'rails_helper'
require 'spec_helper'

describe StaticPagesController, type: :controller do
  render_views
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }
 
  describe 'GET #home' do
    context "when access the page" do
      it 'has a 200 status code' do
        get 'home'
        expect(response).to have_http_status(:ok)
      end
      it 'check home render' do
        get 'home'
        expect(response).to render_template('static_pages/home')
      end
    end

    context "when access #wrong page" do
      it "rejects wrong URI." do
        expect{get('/static_pages/hoge')}.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

  describe 'GET #help' do
    context "when access the page" do
      it 'has a 200 status code' do
        get 'help'
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #about' do
    context "when access the page" do
      it 'has a 200 status the code' do
        get 'about'
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #contact' do
    context "when access the page" do
      it 'has a 200 status code' do
        get 'contact'
        expect(response.status).to eq 200
      end
    end
  end
end
