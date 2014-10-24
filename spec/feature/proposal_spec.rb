require 'spec_helper'

feature "Proposal", %q{
  In order to select proposals
  As an user
  I want to vote, create and comment on proposals
} do

  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:event) { proposal.event }

  context "Viewing proposals" do
    scenario "While not logged in, I should be able to view proposal information" do
      proposal
      visit event_path(event)

      page.should have_no_content 'Sign in'
      page.should have_content 'Refactoring Ruby'
      page.should have_content "0 comments"
      page.should have_css("img[src*='positive.png']")
      page.should have_css("img[src*='negative.png']")
    end

    scenario "While not logged in, I should be able to view proposals' details " do
      proposal
      visit event_proposal_path(event, proposal)

      page.should have_no_content 'Sign in'
      page.should have_content 'Refactoring Ruby'
      page.should have_content '0 comments'
    end
  end

  context "Creating proposals" do
    context 'User without email' do
      let(:user_without_email) do
        user = User.new(
          name: 'Emailess Guy',
          email: 'example@example.com',
          password: '123123',
          password_confirmation: '123123'
        )
        user.save! validate: false
        user
      end

      scenario 'I will be asked for profile completion' do
        # TODO: authenticate this user by other means, so we don't need to
        # erraise the email here...
        sign_in_with user_without_email
        user_without_email.update_column :email, ''

        visit event_path(event)
        find('#left_bar a#add_proposal').click

        expect(page).to have_content 'Editing profile'
        expect(page).to have_content 'Please, complete your profile.'
      end
    end

    scenario "I can create a proposal" do
      sign_in

      visit event_path(event)
      find('#left_bar a#add_proposal').click

      fill_in "Name", :with => 'Refactoring Ruby'
      fill_in 'Description', :with => 'Refactoring Ruby 2nd edition'

      find('input[type=image]').click

      page.should have_content "Refactoring Ruby"
    end

    scenario "While registering, I can't register a proposal without a name" do
      sign_in

      visit event_path(event)
      find('#left_bar a#add_proposal').click

      fill_in 'Description', :with => 'Refactoring Ruby 2nd edition'

      find('input[type=image]').click

      page.should have_content "Name can't be blank"
    end

    scenario "While registering, I can't register a proposal without a name" do
      sign_in

      visit event_path(event)
      find('#left_bar a#add_proposal').click

      fill_in 'Name', :with => 'GURU-SP'

      find('input[type=image]').click

      page.should have_content "Description can't be blank"
    end

    scenario "I can't edit a proposal if I do not own it" do
      visit event_proposal_path(event, proposal)

      page.should have_no_content "Edit"
    end

    scenario "I can edit my proposal while it's under 30 minutes of publication" do
      user = FactoryGirl.create(:user)
      proposal = FactoryGirl.create(:proposal, :created_at => Time.current, :user => user)

      sign_in_with(user)
      visit event_proposal_path(event, proposal)
      click_link 'edit'

      fill_in 'Description', :with => 'Changed description'

      page.should have_content "Changed description"
    end

    scenario "I can't edit my proposal while it's over 30 minutes of publication" do
      user = FactoryGirl.create(:user)
      proposal = FactoryGirl.create(:proposal, :created_at => 1.hour.ago, :user => user)

      sign_in_with(user)
      visit event_proposal_path(event, proposal)

      click_link 'edit'

      page.should have_content "You cannot edit a proposal after 30 minutes of creation."
    end
  end
end
