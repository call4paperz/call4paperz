require 'spec_helper'

describe ApplicationHelper do
  let(:user) { Factory.stub(:user) }

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
      it { should_not match(/Login Twitter/) }
      it { should_not match('/auth/twitter') }
      it { should_not match(/Login Facebook/) }
      it { should_not match('/auth/facebook') }
    end

    context "not logged in" do
      before(:each) do
        helper.should_receive(:user_signed_in?).and_return(false)
      end
      it { should match(/Home/) }
      it { should match(root_url) }
      it { should match(/Events/) }
      it { should match(events_path) }
      it { should match(/Login Twitter/) }
      it { should match('/auth/twitter') }
      it { should match(/Login Facebook/) }
      it { should match('/auth/facebook') }
      it { should_not match(/Logout/) }
      it { should_not match(destroy_user_session_path) }
    end
  end
end
