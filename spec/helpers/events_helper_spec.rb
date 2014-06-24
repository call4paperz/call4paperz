require 'spec_helper'

describe EventsHelper do
  describe "#user_is_owner?" do
    it "reports true if they match" do
      user_stub = double
      model_mock = double(:user => user_stub)

      helper.should_receive(:user_signed_in?).and_return(true)
      helper.should_receive(:current_user).and_return(user_stub)

      helper.user_is_owner?(model_mock).should be true
    end

    it "reports false if they don't" do
      user_stub = double
      model_mock = double(:user => double)

      helper.should_receive(:user_signed_in?).and_return(true)
      helper.should_receive(:current_user).and_return(user_stub)

      helper.user_is_owner?(model_mock).should be false
    end
  end
end
