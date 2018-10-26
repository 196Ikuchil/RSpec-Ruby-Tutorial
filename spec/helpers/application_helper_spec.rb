require 'rails_helper'

describe 'ApplicationHelper' do
  include ApplicationHelper
  describe 'full_title' do
    base_title = "Ruby on Rails Tutorial Sample App"
    it 'full title helper' do
      expect(full_title).to eq(base_title)
    end
    it 'full title helper in Help page' do
      page_title = "Help"
      expect(full_title(page_title)).to eq("#{page_title} | #{base_title}")
    end
  end
end
