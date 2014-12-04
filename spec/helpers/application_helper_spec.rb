require 'spec_helper'

describe ApplicationHelper, :type => :helper do
  let(:user) { FactoryGirl.stub(:user) }

  describe "#menu" do
    subject { helper.menu }

    context "logged in" do
      before(:each) do
        expect(helper).to receive(:user_signed_in?).and_return(true)
      end
      it { is_expected.to match(/Home/) }
      it { is_expected.to match(root_url) }
      it { is_expected.to match(/Events/) }
      it { is_expected.to match(events_path) }
      it { is_expected.to match(/Logout/) }
      it { is_expected.to match(destroy_user_session_path) }
      it { is_expected.not_to match(/Login/) }
      it { is_expected.not_to match(new_user_session_path) }
    end

    context "not logged in" do
      before(:each) do
        expect(helper).to receive(:user_signed_in?).and_return(false)
      end
      it { is_expected.to match(/Home/) }
      it { is_expected.to match(root_url) }
      it { is_expected.to match(/Events/) }
      it { is_expected.to match(events_path) }
      it { is_expected.to match(/Login/) }
      it { is_expected.to match(new_user_session_path) }
      it { is_expected.not_to match(/Logout/) }
      it { is_expected.not_to match(destroy_user_session_path) }
    end
  end

  describe "#render_flash_notice" do
    context "when there is flash notice " do
      it "renders notice message" do
        flash[:notice] = "It is working"
        expect(helper.render_flash_notice).to eq %{<p class="notice">It is working</p>}
      end
    end
    context "when there is no flash notice " do
      it "renders nothing" do
        expect(helper.render_flash_notice).to be_nil
      end
    end
  end
end
