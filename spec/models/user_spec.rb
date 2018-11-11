require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user){ build(:user)}
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
