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

  describe "#render_flash_notice" do
    context "when there is flash notice " do
      it "renders notice message" do
        flash[:notice] = "It is working"
        helper.render_flash_notice.should eq %{<p class="notice">It is working</p>}
      end
    end
    context "when there is no flash notice " do
      it "renders nothing" do
        helper.render_flash_notice.should be_nil
      end
    end
  end

  describe "#image_url" do
    it 'given the image_path, it prepends the domain' do
      helper.image_url('/images/awesome.png').should == 'http://test.host/images/awesome.png'
    end
  end
end
