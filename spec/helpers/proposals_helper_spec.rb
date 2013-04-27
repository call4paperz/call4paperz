require 'spec_helper'

describe ProposalsHelper do
  let(:user) { FactoryGirl.create(:user) }
  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:event) { FactoryGirl.create(:event) }

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
      it { should_not match("ajax_vote") }
    end
  end

  describe "#render_votes_bar" do
    context "when receives -50 votes" do
      it "returns progress bar with 100px width" do
        helper.render_votes_bar(-50).should include %{<div class="red" style="width: 100px"><span>50</span></div>}
      end
    end
    context "when receives 0 votes" do
      it "returns progress bar with 0px width" do
        helper.render_votes_bar(0).should include %{<div class="red" style="width: 0px"><span>0</span></div>}
      end
    end
    context "when receives 50 votes" do
      it "returns progress bar with 100px width" do
        helper.render_votes_bar(50).should include %{<div class="gray" style="width: 100px"><span>50</span></div>}
      end
    end
    context "when receives 100 votes" do
      it "returns progress bar with 200px width" do
        helper.render_votes_bar(100).should include %{<div class="green" style="width: 200px"><span>100</span></div>}
      end
    end
  end
end
