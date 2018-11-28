require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user){create(:user)}
  describe 'model validation' do
    before{@micropost = user.microposts.build(content: "messages")}
    context 'when make new micropost' do

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


  describe 'find' do
    before{@micropost = user.microposts.create(content: "messages")}
    context 'when select a first micropost' do
      it 'return a latest micropost' do
        expect(user.microposts.create(attributes_for(:micropost,:most_recent))).to eq Micropost.first
      end
    end
  end
  describe 'dependency' do
    let(:user){create(:user)}
    before{@micropost = user.microposts.create(content: "messages")}
    context 'when remove user' do
      it 'be removed dependent micropost' do
        expect{user.destroy}.to change{Micropost.count}.from(1).to(0)
      end
    end
  end
end
