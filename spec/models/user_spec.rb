require 'spec_helper'

describe User do

  describe "mass assignment" do

    context "allowed" do
      [:email, :password, :password_confirmation, :remember_me, :name, :photo, :email_confirmation,
       :twitter_avatar].each do |attr|
        it { should allow_mass_assignment_of(attr) }
      end
    end

    context "not allowed" do
      [:id, :encrypted_password, :password_salt, :reset_password_token,
       :remember_token, :remember_created_at, :sign_in_count, :current_sign_in_at,
       :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :reset_password_sent_at,
       :created_at, :updated_at].each do |attr|
        it { should_not allow_mass_assignment_of(attr) }
      end
    end
  end

  describe "associations" do
    it { should have_many(:authentications).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:proposals).dependent(:destroy) }
    it { should have_many(:votes).dependent(:destroy) }
  end

  describe "devise validations overrides" do
    context "password override" do
      it "should not be valid if none is passed" do
        user = User.new
        user.should_not be_valid
        expect(user.errors[:password].size).to eq 1
      end

      it "should not require password when user has authentications and no password" do
        user = User.new
        user.authentications.build({:provider => 'twitter', :uid => '123'}, without_protection: true)
        user.should be_valid
        expect(user.errors[:password].size).to eq 0
      end

      it "should require password when user is being registered with password" do
        user = User.new(:password => '123123', :password_confirmation => '123123')
        expect(user.errors[:password].size).to eq 0
      end

    end
    context "email override" do
      it "should not require email if it has authentications" do
        user = User.new
        user.authentications.build({:provider => 'twitter', :uid => '123'}, without_protection: true)
        user.should be_valid
        expect(user.errors[:email].size).to eq 0
      end

      it "should require email if it has authentications " do
        user = User.new
        expect(user.valid?).to be false
        expect(user.errors[:email].size).to eq 1
      end
    end
  end

  describe "photos" do
    let(:user) { FactoryGirl.build(:user, twitter_avatar: nil, photo: nil) }

    context "when the user has a photo" do
      it "shows the photo" do
        user.photo = File.open(Rails.root.join('spec', 'support', 'fixtures', 'guru_sp.png'))
        user.save!

        user.picture.should match /guru_sp/
      end
    end

    context "when the user has no photo, but has an old avatar" do
      it "shows the twitter avatar" do
        user.twitter_avatar = "hello.png"
        user.picture.should include("hello.png")
      end
    end

    context "when the user has no photo" do
      it "shows the no avatar image" do
        user.picture.should match /no_avatar/
      end
    end
  end
end
