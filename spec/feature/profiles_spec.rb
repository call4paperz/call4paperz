require 'spec_helper'

feature 'Profiles' do
  context 'showing' do
    let(:authentication) do
      Authentication.new(provider: 'github', uid: 'github-uid')
    end
    let(:user) do
      FactoryGirl.create(:user, authentications: [ authentication ])
    end

    before do
      sign_in_with(user)
    end

    scenario 'shows associated profiles' do
      visit '/profile'

      expect(page).to have_selector('#associated-profiles', text: 'Github')
      expect(page).to_not have_selector('#associated-profiles', text: 'Twitter')
    end
  end

  context 'editing' do
    scenario 'updates profile' do
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
  end
end
