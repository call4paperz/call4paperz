require 'spec_helper'

feature 'Profiles' do
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

    expect(page).to_not have_content('Twitter')
    expect(current_path).to eq(profile_path)
  end
end
