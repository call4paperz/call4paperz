require 'spec_helper'

describe UserHelper do
  context "#user_picture" do
    subject { helper.user_picture(user, options) }
    context "without an user" do
      let(:user) { nil }
      it { should match("no_avatar.png") }
    end

    context "user without picture" do
      let(:user) { Factory.stub(:user, :picture => nil) }
      it { should match("no_avatar.png") }
    end

    context "user with picture" do
      let(:user) { Factory.stub(:user, :picture => "123.png") }
      it { should match("123.png") }
    end
    context "with options" do
      let(:user) { nil }
      let(:options) { {:class => 'test'} }
      it { should match('test') }
    end
  end
end
