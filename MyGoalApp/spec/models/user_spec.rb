require 'rails_helper'


RSpec.describe User, type: :model do

  subject(:user) do
    FactoryBot.create(:user)
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:session_token) }

  it { should have_many(:goals) }
  it { should have_many(:comments) }

  describe "::find_by_credentials" do
    before { user.save! }

    it "returns user if the creds are good" do
      expect(User.find_by_credentials("Maja", "starwars")).to eq(user)
    end

    it "returns nil if the creds are bad" do
      expect(User.find_by_credentials("Maja", "blahhhh")).to eq(nil)
    end
  end

  describe "#is_password?" do
    it "checks if a password is valid" do
      expect(user.is_password?("starwars")).to be true
    end

    it "checks if password is invalid" do
      expect(user.is_password?("blah")).to be false
    end

  end

  describe "#reset_session_token!" do
    it "resets the session token" do
      user.valid?
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_session_token)
    end

    it "returns the new session token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  it "creates a password digest when a password is provided" do
    expect(user.password_digest).to_not eq(nil)
  end

  it "create a session token before validation" do
    user.valid?
    expect(user.session_token).to_not eq(nil)
  end

end
