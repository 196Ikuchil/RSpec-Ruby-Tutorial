require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user){create(:user)}
    let(:mail) { UserMailer.account_activation(user) }

    before{user.activation_token = User.new_token}
    context 'when create account_activation mail' do
      it "renders the subject" do
        expect(mail.subject).to eq("Account Activation")
      end
      it 'mail to user' do
        expect(mail.to).to eq([user.email])
      end
      it 'mail from our address' do
        expect(mail.from).to eq(["noreply@example.com"])
      end

      it "renders the body" do
        expect(mail.body.encoded).to match("Hi")
      end

      it 'token include in body' do
        expect(mail.body.encoded).to match(user.activation_token)
      end

      it 'escaped email include in body' do
        expect(mail.body.encoded).to match(CGI.escape(user.email))
      end
    end
  end

  describe "password_reset" do
    let(:user){create(:user)}
    let(:mail) { UserMailer.password_reset(user) }

    before{user.reset_token =User.new_token}
    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it 'token include in body' do
      expect(mail.body.encoded).to match(user.reset_token)
    end

    it 'escaped email include in body' do
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end

end
