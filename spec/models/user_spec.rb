require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl.build(:user) }

  describe "validations" do
    describe "has username, password_digest, and session token" do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_presence_of(:session_token) }
    end
    describe "has unique username and session token" do
      it { should validate_uniqueness_of(:username) }
      it { should validate_uniqueness_of(:session_token) }
    end

    describe "password must be 6 characters or longer" do
      #password length
      it { should validate_length_of(:password).is_at_least(6) }
    end
  end

  describe "associations" do

  end

  describe "instance methods" do
    describe "#is_password?" do
      it "can confirm the password" do
        expect(user.is_password("password")).to be_true
      end
      it "can reject the incorrect password" do
        expect(user.is_password("not_password")).to be_false
      end
    end

    describe "#ensure_session_token" do
      it "generate the session" do
        expect(user.session_token).not_to be_nil
      end
    end

    describe "#reset_session_token!" do
      it "reassign session token" do
        curr_token = user.session_token
        user.reset_session_token!

        expect(user.session_token).not_to be(curr_token)
      end
    end

    describe "#password=" do
      it "assigns password digest" do
        expect(user.password_digest).not_to be_nil
      end

      it "replaces old password" do
        user.password = 'new_password'
        expect(user.password).to be('new_password')

        expect(BCrypt::Password.new(user.password_digest).is_password?('new_password')).to be_true
      end

      it "password not store in database" do
        user.save
        m_user = User.find_by(username: user.username)

        expect(m_user.password).to be_nil
        expect(user.password).not_to be_nil
      end
    end
  end

  describe "class methods" do
    describe "::find_by_credentials" do

    end
  end
end
