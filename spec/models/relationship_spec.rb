require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validation' do
    let(:relationship){Relationship.new(follower_id: create(:user).id,followed_id: create(:user,:michael).id)}
    it "should be valid" do
      expect(relationship).to be_valid
    end
    context 'when follower_id is nil' do
      it 'require' do
        relationship.follower_id = nil
        expect(relationship).to_not be_valid
      end
    end
    context 'when  followed_id is nil ' do
      it 'require' do
        relationship.followed_id = nil
        expect(relationship).to_not be_valid
      end
    end
  end
end
