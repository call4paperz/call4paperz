require 'spec_helper'

describe EventsHelper, :type => :helper do
  describe "#user_is_owner?" do
    it "reports true if they match" do
      user_stub = double
      model_mock = double(:user => user_stub)

      expect(helper).to receive(:user_signed_in?).and_return(true)
      expect(helper).to receive(:current_user).and_return(user_stub)

      expect(helper.user_is_owner? model_mock).to be true
    end

    it "reports false if they don't" do
      user_stub = double
      model_mock = double(:user => double)

      expect(helper).to receive(:user_signed_in?).and_return(true)
      expect(helper).to receive(:current_user).and_return(user_stub)

      expect(helper.user_is_owner? model_mock).to be false
    end
  end
end
