require 'spec_helper'

describe UserHelper do
  context "#user_picture" do
    subject { helper.user_picture(user, {}) }

    context "without an user" do
      let(:user) { nil }
      it { should match("no_avatar.png") }
    end

    context "user with picture without email" do
      let(:user) { Factory.stub(:user, :picture => "123.png", :email => nil) }
      it { should match("no_avatar.png") }
    end

    context "user without picture nor email" do
      let(:user) { Factory.stub(:user, :picture => nil, :email => nil) }
      it { should match("no_avatar.png") }
    end

    context "with options" do
      let(:user) { nil }
      subject { helper.user_picture(user, :class => 'test') }
      it { should match('test') }
    end

    context "without email" do
      let(:user) { Factory.stub(:user, :email => "vinibaggio@gmail.com") }
      it { should match("2ecd441ad4f859f2e98cac90b8ca824e") }
    end
  end
end
