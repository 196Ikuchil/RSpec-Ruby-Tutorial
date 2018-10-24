require 'rails_helper'

describe StaticPagesController, type: :controller do
  render_views
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }
  
  describe 'GET #home' do
    it 'has a 200 status code' do
      get 'home'
      expect(response).to have_http_status(:ok)
      assert_select "title", "Home | #{base_title}"
    end
  end
  describe 'GET #help' do
    it 'has a 200 status code' do
      get 'help'
      expect(response.status).to eq 200
      assert_select "title", "Help | #{base_title}"
    end
  end
  describe 'GET #about' do
    it 'has a 200 status code' do
      get 'about'
      expect(response.status).to eq 200
      assert_select "title", "About | #{base_title}"
    end
  end
end
