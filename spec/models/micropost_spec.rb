require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user){create(:user)}
  before{@micropost = Micropost.new(content:"Messages",user_id:user.id)}
  describe 'model validation' do
    context 'when make new micropost'
      it 'should be valid' do
        expect(@micropost.valid?).to eq true
      end
      it 'user_id should be present' do
        @micropost.user_id=nil
        expect(@micropost.valid?).to eq false
      end
      it 'content should be present' do
        @micropost.content = " "
        expect(@micropost.valid?).to eq false
      end
      it 'content should be at most 140 characters' do
        @micropost.content = "a"*141
        expect(@micropost.valid?).to eq false
      end
  end
end
