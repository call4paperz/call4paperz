require 'spec_helper'

feature 'Profiles', %q{
  In order update my profile
  As an user
  I want to edit my name and upload a new picture
} do

  context 'Editing profile' do
    scenario 'I can updating my profile' do
      sign_in
      visit '/profile'
      click_link 'Edit profile'

      within 'form.edit_user' do
        fill_in 'Name', with: 'John Doe'
        attach_file 'Picture', "#{Rails.root}/spec/support/fixtures/guru_sp.png"
        find('input[type=image]').click
      end

      expect(page).to have_content('User was successfully updated.')
      expect(page).to have_content('John Doe')
      expect(page).to have_selector("img[src$='guru_sp.png']")
    end
  end
end
