require 'rails_helper'

feature 'Site Layout',type: :feature do

  scenario 'layout links' do
    visit root_path

    link = find('a',text: 'sample app')
    expect(link[:href]).to eq root_path
    link = find('a', text: 'Home')
    expect(link[:href]).to eq root_path
    link = find('a', text: 'Help')
    expect(link[:href]).to eq help_path
    link = find('a', text: 'About')
    expect(link[:href]).to eq about_path
    link = find('a', text: 'Contact')
    expect(link[:href]).to eq contact_path
  end
end