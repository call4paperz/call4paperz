require 'spec_helper'

describe EventsHelper do
  describe "#user_is_owner?" do
    it "reports true if they match" do
      user_stub = stub
      model_mock = mock(:user => user_stub)

      helper.should_receive(:current_user).and_return(user_stub)

      helper.user_is_owner?(model_mock).should be_true
    end

    it "reports false if they don't" do
      user_stub = stub
      model_mock = mock(:user => stub)

      helper.should_receive(:current_user).and_return(user_stub)

      helper.user_is_owner?(model_mock).should be_false
    end
  end
end
