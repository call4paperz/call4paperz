require 'spec_helper'

describe Vote do
  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:user) { FactoryGirl.create(:user) }

  describe ".like!" do
    it "should generate a vote for the specified proposal and user" do
      expect {
        vote = described_class.like!(proposal, user)
      }.to change(Vote, :count).by(1)
    end

    it "should set properties of vote correctly" do
      vote = described_class.like!(proposal, user)
      vote.proposal.should == proposal
      vote.user.should == user
      vote.direction.should == Vote::LIKE
    end
  end

  describe ".dislike!" do
    it "should generate a vote for the specified proposal and user" do
      expect {
        vote = described_class.dislike!(proposal, user)
      }.to change(Vote, :count).by(1)
    end

    it "should set properties of vote correctly" do
      vote = described_class.dislike!(proposal, user)
      vote.proposal.should == proposal
      vote.user.should == user
      vote.direction.should == Vote::DISLIKE
    end
  end
end
