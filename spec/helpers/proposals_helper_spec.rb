require 'spec_helper'

describe ProposalsHelper do
  let(:user) { Factory(:user) }
  let(:proposal) { Factory(:proposal) }
  let(:event) { Factory(:event) }

  describe "#vote_box" do
    context "user is set and has voted" do
      before(:each) do
        Vote.like!(proposal, user)
      end

      subject { helper.vote_box(event, proposal,user) }
      it { should match(/Thanks for voting!/)}
    end

    context "no user" do
      subject { helper.vote_box(event, proposal, nil) }
      it { should match(like_event_proposal_path(event, proposal)) }
      it { should match(dislike_event_proposal_path(event, proposal)) }
    end
  end
end
