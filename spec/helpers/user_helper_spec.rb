require 'spec_helper'

RSpec.describe UserHelper, type: :helper do
  context '#user_picture' do
    subject { helper.user_picture(user, {}) }

    context 'without an user' do
      let(:user) { nil }

      it { is_expected.to match('no_avatar.png') }
    end

    context 'user without picture' do
      let(:user) { FactoryBot.build(:user, photo: nil) }

      it { is_expected.to match('no_avatar.png') }
    end

    context 'user with picture' do
      let(:user) { FactoryBot.build(:user) }

      before do
        allow(user).to receive(:picture).and_return(OpenStruct.new(thumb: '/path/123.png'))
      end

      it { is_expected.to match('123.png') }
    end

    context 'with options' do
      let(:user) { nil }
      subject { helper.user_picture(user, class: 'test') }

      it { is_expected.to match('test') }
    end
  end
end
