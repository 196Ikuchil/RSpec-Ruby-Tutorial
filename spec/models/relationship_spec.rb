require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validation' do
    let(:relationship){Relationship.new(follower_id: create(:user).id,followed_id: create(:user,:michael).id)}
    it "should be valid" do
      expect(relationship.valid?).to eq true
    end
    context 'when follower_id is nil' do
      it 'require' do
        relationship.follower_id = nil
        expect(relationship.valid?).to eq false
      end
    end
    context 'when  followed_id is nil ' do
      it 'require' do
        relationship.followed_id = nil
        expect(relationship.valid?).to eq false
      end
    end
  end
end
