require 'spec_helper'

describe Event do
  context ".occurs_first" do
    it "should sort the next to occur first" do
      late_event = FactoryGirl.create(:event, :occurs_at => 5.day.from_now)
      early_event = FactoryGirl.create(:event, :occurs_at => 1.day.from_now)

      described_class.occurs_first.should == [early_event, late_event]
    end
  end

  context ".active" do
    it "should find events from the future!" do
      ev = FactoryGirl.create(:event, :occurs_at => 5.days.from_now)
      described_class.active.should == [ev]
    end

    it "should include events from today" do
      ev = FactoryGirl.create(:event)
      described_class.active.should == [ev]
    end

    it "should not inclue events from the past" do
      Timecop.freeze(2.days.ago)
      ev = FactoryGirl.create(:event, :occurs_at => Time.current)
      Timecop.return

      described_class.active.should be_empty
    end
  end
end
