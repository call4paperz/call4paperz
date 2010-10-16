require File.dirname(__FILE__) + '/acceptance_helper'

feature "Comment", %q{
  In order to talk to other people
  As an user
  I want to make comments about proposals
} do

  let(:proposal) { Factory(:proposal) }
  let(:event) { proposal.event }

  scenario "I should see the number of comments change appropriately" do
    visit event_page(event)
    page.should have_content "0 comments"

    Factory(:comment, :proposal => proposal)
    Factory(:comment, :proposal => Factory(:proposal, :event => event))

    visit event_page(event)
    page.should have_content "1 comment"
    page.should have_no_content "2 comments"
  end

  scenario "I shouldn't be able to make comments while not logged in" do
    visit proposal_page(proposal)

    fill_in "Body", :with => 'Lorem Ipsum Dolor'
    click_button 'Create Comment'

    page.should have_no_content "Comment was successfully created."
    page.should have_content "Sign in"
  end

  scenario "I should be able to make comments while logged in" do
    sign_in

    visit proposal_page(proposal)

    fill_in "Body", :with => 'Lorem Ipsum Dolor'
    click_button 'Create Comment'

    page.should have_no_content "Sign in"
    page.should have_content "Comment was successfully created."
    page.should have_content 'Lorem Ipsum Dolor'
  end
end
