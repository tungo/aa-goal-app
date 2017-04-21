require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl.build(:user) }

  describe "validations" do
    # it "has unique username and session token"
    describe "has not null username, password_digest, and session token" do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_presence_of(:session_token) }
    end
    #it "validates password"
  end

  describe "associations" do

  end

  describe "instance methods" do
    describe "#is_password?" do

    end

    describe "#reset_session_token" do

    end

    describe "#ensure_session_token" do

    end

    describe "#password=" do

    end
  end

  describe "class methods" do
    describe "::find_by_credentials" do

    end
  end
end
