require 'spec_helper'

describe ProposalsHelper, :type => :helper do
  let(:user) { FactoryGirl.create(:user) }
  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:event) { FactoryGirl.create(:event) }

  describe "#vote_box" do
    context "user is set and has voted" do
      before(:each) do
        Vote.like(proposal, user)
      end

      subject { helper.vote_box(event, proposal,user) }
      it { is_expected.to match(/Thanks for voting!/)}
    end

    context "no user" do
      subject { helper.vote_box(event, proposal, nil) }
      it { is_expected.to match(like_event_proposal_path(event, proposal)) }
      it { is_expected.to match(dislike_event_proposal_path(event, proposal)) }
      it { is_expected.not_to match("ajax_vote") }
    end
  end

  describe "#render_votes_bar" do
    context "when receives -50 votes" do
      it "returns progress bar with 100px width" do
        expect(helper.render_votes_bar(-50)).to include %{<div class="red" style="width: 100px"><span>50</span></div>}
      end
    end
    context "when receives 0 votes" do
      it "returns progress bar with 0px width" do
        expect(helper.render_votes_bar(0)).to include %{<div class="red" style="width: 0px"><span>0</span></div>}
      end
    end
    context "when receives 50 votes" do
      it "returns progress bar with 100px width" do
        expect(helper.render_votes_bar(50)).to include %{<div class="gray" style="width: 100px"><span>50</span></div>}
      end
    end
    context "when receives 100 votes" do
      it "returns progress bar with 200px width" do
        expect(helper.render_votes_bar(100)).to include %{<div class="green" style="width: 200px"><span>100</span></div>}
      end
    end
    context "when receives more than 100 votes" do
      it "returns progress bar with 200px width" do
        expect(helper.render_votes_bar(136)).to include %{<div class="green" style="width: 200px"><span>136</span></div>}
      end
    end
    context "when receives more than 100 negatives votes" do
      it "returns progress bar with 100px width" do
        expect(helper.render_votes_bar(-140)).to include %{<div class="red" style="width: 200px"><span>140</span></div>}
      end
    end
  end

  describe "#last_comment?" do
    let(:comments) { [Comment.new, Comment.new] }

    context "when given comment is the last" do
      it "returns true" do
        expect(helper.last_comment?(comments, 1)).to be_truthy
      end
    end

    context "when given comment is not the last" do
      it "returns false" do
        expect(helper.last_comment?(comments, 0)).to be_falsy
      end
    end
  end
end
