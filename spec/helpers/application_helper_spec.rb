require 'rails_helper'

describe 'ApplicationHelper' do
  include ApplicationHelper
  describe 'full_title' do
    it 'full title helper' do
      base_title = "Ruby on Rails Tutorial Sample App"
      page_title = "Help"
      expect(full_title).to eq(base_title)
      expect(full_title(page_title)).to eq("#{page_title} | #{base_title}")
    end
  end
end
