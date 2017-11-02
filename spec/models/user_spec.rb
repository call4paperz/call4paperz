require 'spec_helper'

describe User, :type => :model do

  describe 'associations' do
    it { is_expected.to have_many(:authentications).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:events).dependent(:destroy) }
    it { is_expected.to have_many(:proposals).dependent(:destroy) }
    it { is_expected.to have_many(:votes).dependent(:destroy) }
  end

  describe 'devise validations overrides' do
    context 'password override' do
      it 'should not be valid if none is passed' do
        user = User.new
        expect(user).not_to be_valid
        expect(user.errors[:password].size).to eq 1
      end

      it 'should not require password when user has authentications and no password' do
        user = User.new
        user.authentications.build(:provider => 'twitter', :uid => '123')
        expect(user).to be_valid
        expect(user.errors[:password].size).to eq 0
      end

      it 'should require password when user is being registered with password' do
        user = User.new(:password => '123123', :password_confirmation => '123123')
        expect(user.errors[:password].size).to eq 0
      end

    end

    context 'email override' do
      it 'should not require email if it has authentications' do
        user = User.new
        user.authentications.build(:provider => 'twitter', :uid => '123')
        expect(user).to be_valid
        expect(user.errors[:email].size).to eq 0
      end

      it 'should require email if it has authentications ' do
        user = User.new
        expect(user.valid?).to be false
        expect(user.errors[:email].size).to eq 1
      end
    end
  end

  describe 'photos' do
    let(:user) { FactoryBot.build(:user, photo: nil) }

    context 'when the user has a photo' do
      it 'shows the photo' do
        user.photo = File.open(Rails.root.join('spec', 'support', 'fixtures', 'guru_sp.png'))
        user.save!

        expect(user.picture).to match /guru_sp/
      end
    end

    context 'when the user has no photo' do
      it 'returns nil' do
        expect(user.picture).to be_nil
      end
    end
  end
end
