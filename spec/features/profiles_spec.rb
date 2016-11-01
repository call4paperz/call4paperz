require 'spec_helper'

feature 'Profiles' do
  context 'showing user profile' do
    let(:user) do
      FactoryGirl.create(:user, authentications: authentications)
    end

    before do
      sign_in_with(user)
    end

    context 'when user has associated profiles' do
      let(:authentications) do
        [Authentication.new(provider: 'github', uid: 'github-uid')]
      end

      scenario 'shows associated profiles' do
        visit '/profile'

        expect(page).to have_selector('#associated-profiles', text: 'Github')
        expect(page).to_not have_selector('#associated-profiles', text: 'Twitter')
      end
    end

    context 'when user has no associated profiles' do
      let(:authentications) { [] }

      scenario 'does not show anything' do
        expect(page).to_not have_selector('#associated-profiles')
      end
    end
  end

  scenario 'updating user profile' do
    sign_in
    visit '/profile'
    click_link 'Edit profile'

    within 'form.edit_user' do
      fill_in 'Name', with: 'John Doe'
      attach_file 'Picture', fixture_file('guru_sp.png')
      find('input[type=image]').click
    end

    expect(page).to have_content('Profile was successfully updated.')
    expect(page).to have_content('John Doe')
    expect(page).to have_selector("img[src$='guru_sp.png']")
  end

  scenario 'linking user profile with a social account' do
    sign_in
    visit '/profile'

    twitter_uid = 'twitter-123'
    mock_omniauth_provider(twitter_uid, :twitter)

    expect(page).to have_content('Twitter')

    click_link 'Twitter'

    expect(page).to have_selector('#associated-profiles', text: 'Twitter')
    expect(current_path).to eq(profile_path)
  end
end
