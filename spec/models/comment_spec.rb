require 'spec_helper'

describe Comment, :type => :model do

  describe "validations" do

    describe "requireds" do
      it { is_expected.to validate_presence_of(:body) }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:proposal) }
  end
end
