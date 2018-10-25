require 'rails_helper'

feature 'Application', type: :feature do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }
  scenario 'get home title' do
    visit 'static_pages/home'
    expect(page).to have_title("#{base_title}",exact: true )
  end
  scenario 'get help title' do
    visit 'static_pages/help'
    expect(page).to have_title("Help | #{base_title}",exact:true)
  end
  scenario 'get about title' do
    visit 'static_pages/about'
    expect(page).to have_title("About | #{base_title}",exact:true)
  end
  scenario 'get contact title' do
    visit 'static_pages/contact'
    expect(page).to have_title("Contact | #{base_title}", exact:true)
  end
end