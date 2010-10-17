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

  scenario "I should be able to see people's comments" do
    Factory(:comment, :proposal => proposal)
    visit proposal_page(proposal)

    page.should have_content("Lorem Ipsum Dolor")
  end

  scenario "I shouldn't be able to make comments while not logged in" do
    visit proposal_page(proposal)

    fill_in "comment_body", :with => 'Lorem Ipsum Dolor'
    find('.submit_comment').click

    page.should have_no_content "Comment was successfully created."
    page.should have_content "Login"
  end

  scenario "I should be able to make comments while logged in" do
    sign_in

    visit proposal_page(proposal)

    fill_in "comment_body", :with => 'Lorem Ipsum Dolor'
    find('.submit_comment').click

    page.should have_no_content "Login"
    page.should have_content 'Lorem Ipsum Dolor'
  end
end
