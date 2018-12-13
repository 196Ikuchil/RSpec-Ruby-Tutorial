require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user){ build(:user)}
  describe "#create" do
    context 'when create collect info' do
      it 'name should be valid' do
        expect(user).to be_valid
      end
      it 'email addresses should be saved as lower-case' do
        mixed_case_email = "Foo@ExAMPle.CoM"
        user.email = mixed_case_email
        user.save
        expect(user.reload.email).to eq mixed_case_email.downcase
      end
    end

    context 'when create incollect info' do
      it 'name should be present' do
        user.name=nil
        expect(user).not_to be_valid
      end

      it 'email should be present' do
        user.email= nil
        expect(user).not_to be_valid
      end

      it 'name should not be too long' do
        user.name = 'a'*51
        expect(user).not_to be_valid
      end

      it 'email should not be too long' do
        user.email = 'a'*244+'@example.com'
        expect(user).not_to be_valid
      end

      it 'email validation should accept valid addresses' do
        valid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
        valid_addresses.each do |valid_address|
          user.email = valid_address
          expect(user).not_to be_valid,  "#{valid_address.inspect} should be invalid"
        end
      end

      it 'email addresses should be unique' do
        create(:user)
        user.email.upcase!
        expect(user).not_to be_valid
      end

      it 'password should be present (nonblank)' do
        user.password = " "*6
        expect(user).not_to be_valid
      end

      it 'password_confirmation should be present (nonblank)' do
        user.password_confirmation = " "*6
        expect(user).not_to be_valid
      end

      it 'password should have a minimum length' do
        user.password = "a"*5
        expect(user).not_to be_valid
      end

      it 'password_confirmation should have a minimum length' do
        user.password_confirmation = "a"*5
        expect(user).not_to be_valid
      end
    end
  end

  describe "user helper" do
    context "when user with nil digest" do
      it 'return false' do
        expect(user.authenticated?(:remember,'')).to eq false
      end
    end
  end

  describe 'User method' do
    let(:users){create_list(:other_user,40)}
    describe 'paginate_filter' do
      it '有効アカウントのみ取得' do
        users
        User.paginate_filter(page: 1).each do |u|
          expect(u.activated?).to eq true
        end
      end
    end
  end

  describe 'user follow' do
    let(:user){create(:user)}
    let(:michael){create(:user,:michael)}

    before{
      user
      michael
    }
    context 'when default state' do
      it 'no follow each other' do
        expect(user.following?(michael)).to eq user.following.include?(michael)
      end
    end
    context 'when following' do
      it 'following user' do
        user.follow(michael)
        expect(user.following?(michael)).to eq true
      end
      it 'followed michael' do
        user.follow(michael)
        expect(michael.followers.include?(user)).to eq true
      end
    end
    context 'when remove follow' do
      it 'following remove' do
        user.follow(michael)
        user.unfollow(michael)
        expect(user.following?(michael)).to eq false
      end

      it 'follower remove' do
        user.follow(michael)
        user.unfollow(michael)
        expect(michael.followers.include?(user)).to eq false
      end
    end
  end

  describe 'own feed' do
    let(:user){create(:user)}
    let(:michael){create(:user,:michael)}
    let(:archer){create(:user,:archer)}

    before{
      user.follow(michael)
    }
    it 'include followers post' do
      michael.microposts.each do |pst|
        expect(user.feed.include?(pst))
      end
    end
    it 'include own post' do
      user.microposts.each do |pst|
        expect(user.feed.include?(pst))
      end
    end
    it 'not include other users post' do
      archer.microposts.each do |pst|
        expect(user.feed.include?(pst))
      end
    end
  end
end
