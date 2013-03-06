require 'spec_helper'

describe Proposal do
  let(:proposal) { FactoryGirl.create(:proposal)  }

  describe "preloads comments count" do
    it "preloads the count" do
      3.times { FactoryGirl.create(:comment, :proposal => proposal)}

      proposal_from_db = described_class.with_preloads.find(proposal.id)
      proposal_from_db.attributes['comments_count'].to_i.should == 3
    end
  end

  describe "acceptance points" do
    context "preloading acceptance points" do
      it "assigns acceptance points as attribute" do
        FactoryGirl.create(:negative_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:positive_vote, :proposal => proposal)}

        proposal_from_db = described_class.with_preloads.find(proposal.id)
        proposal_from_db.attributes['acceptance_points'].to_i.should == 2
        proposal_from_db.acceptance_points.should == 2
      end

      it "orders by acceptance points" do
        FactoryGirl.create(:negative_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:positive_vote, :proposal => proposal)}

        another_proposal = FactoryGirl.create(:proposal)
        3.times { FactoryGirl.create(:positive_vote, :proposal => another_proposal)}

        first_proposal, second_proposal = described_class.with_preloads

        first_proposal.should == another_proposal
        first_proposal.acceptance_points.should == 3

        second_proposal.should == proposal
        second_proposal.acceptance_points.should == 2
      end

      it "includes proposals with no votes" do
        lonely_proposal = FactoryGirl.create(:proposal)

        described_class.with_preloads.should include(lonely_proposal)
      end
    end

    context "no votes" do
      it "should return 0" do
        proposal.acceptance_points.should == 0
      end
    end

    context "with more positive than negative votes" do
      it "returns a positive value" do
        FactoryGirl.create(:negative_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:positive_vote, :proposal => proposal)}

        proposal.acceptance_points.should == 2
      end
    end

    context "with more negative than positive votes" do
      it "returns a negative value" do
        FactoryGirl.create(:positive_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:negative_vote, :proposal => proposal)}

        proposal.acceptance_points.should == -2
      end
    end

    context "with no negative votes" do
      it "returns a positive value" do
        FactoryGirl.create(:positive_vote, :proposal => proposal)
        proposal.acceptance_points.should == 1
      end
    end
  end

  describe "grace period calculation" do
    context "with grace period left" do
      let(:proposal) { FactoryGirl.build(:proposal, :created_at => 10.minutes.ago) }

      it "returns the number of seconds of grace period" do
        proposal.should have_grace_period_left
        proposal.grace_period_left.should be_within(2).of(1200)
      end
    end

    context "with no grace period left" do
      let(:old_proposal) { FactoryGirl.build(:proposal, :created_at => 30.days.ago) }

      it "returns 0 as grace period" do
        old_proposal.should_not have_grace_period_left
        old_proposal.grace_period_left.should be(0)
      end
    end
  end
end
