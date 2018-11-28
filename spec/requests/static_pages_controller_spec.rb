require 'rails_helper'
require 'spec_helper'

describe StaticPagesController, type: :request do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }
 
  describe 'GET #home' do
    context "when access the page" do
      it 'has a 200 status code' do
        get root_path
        expect(response).to have_http_status(:ok)
      end
      it 'check home render' do
        get root_path
        expect(response).to render_template('static_pages/home')
      end
    end
  end

  describe 'GET #help' do
    context "when access the page" do
      it 'has a 200 status code' do
        get help_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #about' do
    context "when access the page" do
      it 'has a 200 status the code' do
        get about_path
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #contact' do
    context "when access the page" do
      it 'has a 200 status code' do
        get contact_path
        expect(response.status).to eq 200
      end
    end
  end
end
