require 'spec_helper'

feature "Proposal", %q{
  In order to select proposals
  As an user
  I want to vote, create and comment on proposals
} do

  let(:proposal) { FactoryBot.create(:proposal) }
  let(:event) { proposal.event }

  context "Viewing proposals" do
    scenario "While not logged in, I should be able to view proposal information" do
      proposal
      visit event_path(event)

      expect(page).to have_no_content 'Sign in'
      expect(page).to have_content 'Refactoring Ruby'
      expect(page).to have_content "0 comments"
      expect(page).to have_css("img[src*='positive.png']")
      expect(page).to have_css("img[src*='negative.png']")
    end

    scenario "While not logged in, I should be able to view proposals' details " do
      proposal
      visit event_proposal_path(event, proposal)

      expect(page).to have_no_content 'Sign in'
      expect(page).to have_content 'Refactoring Ruby'
      expect(page).to have_content '0 comments'
    end
  end

  context "Creating proposals" do
    scenario "I can create a proposal" do
      sign_in

      visit event_path(event)
      find('#left_bar a#add_proposal').click

      fill_in "Name", :with => 'Refactoring Ruby'
      fill_in 'Description', :with => 'Refactoring Ruby 2nd edition'

      find('input[type=image]').click

      expect(page).to have_content "Refactoring Ruby"
    end

    scenario "While registering, I can't register a proposal without a name" do
      sign_in

      visit event_path(event)
      find('#left_bar a#add_proposal').click

      fill_in 'Description', :with => 'Refactoring Ruby 2nd edition'

      find('input[type=image]').click

      expect(page).to have_content "Name can't be blank"
    end

    scenario "While registering, I can't register a proposal without a name" do
      sign_in

      visit event_path(event)
      find('#left_bar a#add_proposal').click

      fill_in 'Name', :with => 'GURU-SP'

      find('input[type=image]').click

      expect(page).to have_content "Description can't be blank"
    end

    scenario "I can't edit a proposal if I do not own it" do
      visit event_proposal_path(event, proposal)

      expect(page).to have_no_content "Edit"
    end

    scenario "I can edit my proposal while it's under 30 minutes of publication" do
      user = FactoryBot.create(:user)
      proposal = FactoryBot.create(:proposal, :created_at => Time.current, :user => user, event: event)

      sign_in_with(user)
      visit event_proposal_path(event, proposal)
      click_link 'edit'

      fill_in 'Description', :with => 'Changed proposal description'

      click_button 'Save'

      expect(page).to have_content "Changed proposal description"
    end

    scenario "I can't edit my proposal while it's over 30 minutes of publication" do
      user = FactoryBot.create(:user)
      proposal = FactoryBot.create(:proposal, :created_at => 1.hour.ago, :user => user)

      sign_in_with(user)
      visit event_proposal_path(event, proposal)

      click_link 'edit'

      expect(page).to have_content "You cannot edit a proposal after 30 minutes of creation."
    end
  end
end
