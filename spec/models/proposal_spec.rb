require 'spec_helper'

describe Proposal do
  let(:proposal) { Factory(:proposal)  }
  describe "#acceptance_percentage" do
    context "no votes" do
      it "should return 50.00" do
        proposal.acceptance_percentage.should == 50.0
      end
    end

    context "with more positive than negative votes" do
      it "should return a positive value" do
        Factory(:negative_vote, :proposal => proposal)
        3.times { Factory(:positive_vote, :proposal => proposal)}

        proposal.acceptance_percentage.should == 75.00
      end
    end

    context "with more negative than positive votes" do
      it "should return a negative value" do
        Factory(:positive_vote, :proposal => proposal)
        3.times { Factory(:negative_vote, :proposal => proposal)}

        proposal.acceptance_percentage.should == -75.00
      end
    end

    context "with no negative votes" do
      it "should return a negative value" do
        Factory(:positive_vote, :proposal => proposal)
        proposal.acceptance_percentage.should == 100.00
      end
    end
  end
end
