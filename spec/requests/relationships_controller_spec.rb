require 'rails_helper'

RSpec.describe RelationshipsController, type: :request do

  describe 'create' do
    let(:user){create(:user)}
    let(:michael){create(:user,:michael)}
    let(:login){login_in_request(user)}
    describe 'standard post' do
      subject{post relationships_path, params:{followed_id: michael.id}}
      before{
        user
        michael
      }
      context 'when logged in' do
        it 'increment relationship count' do
          login
          expect{subject}.to change{Relationship.count}.by(1)
        end
      end
      context 'when not logged in' do
        it 'not increment relasionship count' do
          expect{subject}.to_not change{Relationship.count}
        end
        it 'redirect to login path' do
          subject
          expect(response).to redirect_to(login_path)
        end
      end
    end
    describe 'ajax post' do
      subject{post relationships_path,xhr: true, params:{followed_id: michael.id}}
      before{
        user
        michael
      }
      context 'when logged in' do
        it 'increment relationship count' do
          login
          expect{subject}.to change{Relationship.count}.by(1)
        end
      end
    end
  end

  describe 'destroy' do
    let(:user){create(:user)}
    let(:michael){create(:user,:michael)}
    let(:login){login_in_request(user)}
    let(:relation){
      user.follow(michael)
      michael.follow(user)
      user.active_relationships.find_by(followed_id: michael.id)
    }

    describe 'standard post' do
      subject{delete relationship_path(relation)}
      before{
        relation
      }
      context 'when logged in' do
        it 'increment relationship count' do
          login
          expect{subject}.to change{Relationship.count}.by(-1)
        end
      end
      context 'when not logged in' do
        it 'not decrement relationship count' do
          expect{subject}.to_not change{Relationship.count}
        end
        it 'redirect to login path' do
          subject
          expect(response).to redirect_to(login_path)
        end
      end
    end

    describe 'ajax post' do
      subject{delete relationship_path(relation),xhr:true}
      before{
        relation
      }
      context 'when logged in' do
        it 'decrement followers count' do
          login
          expect{subject}.to change{Relationship.count}.by(-1)
        end
      end
    end
  end
end
