require 'rails_helper'

feature 'Application', type: :feature do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }
  scenario 'get home title' do
    visit '/'
    expect(page).to have_title("#{base_title}",exact: true )
  end
  scenario 'get help title' do
    visit '/help'
    expect(page).to have_title("Help | #{base_title}",exact:true)
  end
  scenario 'get about title' do
    visit '/about'
    expect(page).to have_title("About | #{base_title}",exact:true)
  end
  scenario 'get contact title' do
    visit '/contact'
    expect(page).to have_title("Contact | #{base_title}", exact:true)
  end
end