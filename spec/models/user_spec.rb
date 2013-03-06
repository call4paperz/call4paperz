require 'spec_helper'

describe User do
  describe "devise validations overrides" do
    context "password override" do
      it "should not be valid if none is passed" do
        user = User.new
        user.should_not be_valid
        user.should have(1).errors_on(:password)
      end

      it "should not require password when user has authentications and no password" do
        user = User.new
        user.authentications.build({:provider => 'twitter', :uid => '123'}, without_protection: true)
        user.should be_valid
        user.should have(0).errors_on(:password)
      end

      it "should require password when user is being registered with password" do
        user = User.new(:password => '123123', :password_confirmation => '123123')
        user.should have(0).errors_on(:password)
      end

    end
    context "email override" do
      it "should not require email if it has authentications" do
        user = User.new
        user.authentications.build({:provider => 'twitter', :uid => '123'}, without_protection: true)
        user.should be_valid
        user.should have(0).errors_on(:email)
      end

      it "should require email if it has authentications " do
        user = User.new
        user.should have(1).errors_on(:email)
      end
    end
  end
end
