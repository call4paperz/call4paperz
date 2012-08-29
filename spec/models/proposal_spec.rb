require 'spec_helper'

describe Proposal do
  let(:proposal) { FactoryGirl.create(:proposal)  }
  describe "#acceptance_points" do
    context "no votes" do
      it "should return 0" do
        proposal.acceptance_points.should == 0
      end
    end

    context "with more positive than negative votes" do
      it "should return a positive value" do
        FactoryGirl.create(:negative_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:positive_vote, :proposal => proposal)}

        proposal.acceptance_points.should == 2
      end
    end

    context "with more negative than positive votes" do
      it "should return a negative value" do
        FactoryGirl.create(:positive_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:negative_vote, :proposal => proposal)}

        proposal.acceptance_points.should == -2
      end
    end

    context "with no negative votes" do
      it "should return a negative value" do
        FactoryGirl.create(:positive_vote, :proposal => proposal)
        proposal.acceptance_points.should == 1
      end
    end
  end

  describe "#grace_period_left" do
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
