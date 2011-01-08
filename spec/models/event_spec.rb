require 'spec_helper'

describe Event do
  context ".occurs_first" do
    it "should sort the next to occur first" do
      late_event = Factory(:event, :occurs_at => 5.day.from_now)
      early_event = Factory(:event, :occurs_at => 1.day.from_now)

      described_class.occurs_first.should == [early_event, late_event]
    end
  end
end
