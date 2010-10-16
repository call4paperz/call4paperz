require File.dirname(__FILE__) + '/acceptance_helper'

feature "Proposal", %q{
  In order to select proposals
  As an user
  I want to vote, create and comment on proposals
} do

  let(:proposal) { Factory(:proposal) }
  let(:event) { proposal.event }

  context "Viewing proposals" do
    scenario "While not logged in, I should be able to view proposal information" do
      proposal
      visit event_page(event)

      page.should have_no_content 'Sign in'
      page.should have_content 'Refactoring Ruby'
      page.should have_content "0 comments"
      page.should have_css("img[src*='positive.png']")
      page.should have_css("img[src*='negative.png']")
    end

    scenario "While not logged in, I should be able to view proposals' details " do
      proposal
      visit proposal_page(proposal)

      page.should have_no_content 'Sign in'
      page.should have_content 'Refactoring Ruby'
      page.should have_content 'Comments'
    end
  end

  context "Creating proposals" do
    scenario "I can create a proposal" do
      sign_in

      visit event_proposals_page(event)
      click_link 'New Proposal'

      fill_in "Name", :with => 'Refactoring Ruby'
      fill_in 'Description', :with => 'Refactoring Ruby 2nd edition'

      click_button "Create Proposal"

      page.should have_content "Refactoring Ruby"
    end

    scenario "While registering, I can't register a proposal without a name" do
      sign_in

      visit event_proposals_page(event)
      click_link 'New Proposal'

      fill_in 'Description', :with => 'Refactoring Ruby 2nd edition'

      click_button "Create Proposal"

      page.should have_content "Name can't be blank"
    end

    scenario "While registering, I can't register a proposal without a name" do
      sign_in

      visit event_proposals_page(event)
      click_link 'New Proposal'

      fill_in 'Name', :with => 'GURU-SP'

      click_button "Create Proposal"

      page.should have_content "Description can't be blank"
    end
  end
end
