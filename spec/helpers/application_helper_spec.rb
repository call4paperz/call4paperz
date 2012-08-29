require 'spec_helper'

describe ApplicationHelper do
  let(:user) { FactoryGirl.stub(:user) }

  describe "#menu" do
    subject { helper.menu }

    context "logged in" do
      before(:each) do
        helper.should_receive(:user_signed_in?).and_return(true)
      end
      it { should match(/Home/) }
      it { should match(root_url) }
      it { should match(/Events/) }
      it { should match(events_path) }
      it { should match(/Logout/) }
      it { should match(destroy_user_session_path) }
      it { should_not match(/Login/) }
      it { should_not match(new_user_session_path) }
    end

    context "not logged in" do
      before(:each) do
        helper.should_receive(:user_signed_in?).and_return(false)
      end
      it { should match(/Home/) }
      it { should match(root_url) }
      it { should match(/Events/) }
      it { should match(events_path) }
      it { should match(/Login/) }
      it { should match(new_user_session_path) }
      it { should_not match(/Logout/) }
      it { should_not match(destroy_user_session_path) }
    end
  end
end
