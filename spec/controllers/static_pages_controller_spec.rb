require 'rails_helper'

describe StaticPagesController, type: :controller do
  describe 'GET #home' do
    it 'has a 200 status code' do
      get 'home'
      expect(response).to have_http_status(:ok)
    end
    #it 'find a title tag' do
    #  visit '/static_pages/home'
    #  expect(page).to have_title 'Home | Ruby on Rails Tutorial Sample App'
    #end
  end
  describe 'GET #help' do
    it 'has a 200 status code' do
      get 'help'
      expect(response.status).to eq 200
    end
    #it 'find a title tag' do
    #  visit 'help'
    #  expect(page).to have_selector 'title',text: 'Home | Ruby on Rails Tutorial Sample App'
    #end 
  end
  describe 'GET #about' do
    it 'has a 200 status code' do
      get 'about'
      expect(response.status).to eq 200
    end
    #it 'find a title tag' do
    #  visit 'about'
    #  expect(page).to have_selector 'title',text: 'Home | Ruby on Rails Tutorial Sample App'
    #end
  end
end
