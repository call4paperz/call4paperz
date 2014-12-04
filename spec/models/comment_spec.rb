require 'spec_helper'

describe Comment, :type => :model do

  describe "mass assignment" do

    context "allowed" do
      [:body, :proposal_id].each do |attr|
        it { is_expected.to allow_mass_assignment_of(attr) }
      end
    end

    context "not allowed" do
      [:id, :user_id, :created_at, :updated_at].each do |attr|
        it { is_expected.not_to allow_mass_assignment_of(attr) }
      end
    end
  end

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
