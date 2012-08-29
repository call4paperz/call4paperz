require 'spec_helper'

feature "Comment", %q{
  In order to talk to other people
  As an user
  I want to make comments about proposals
} do

  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:event) { proposal.event }

  scenario "I should see the number of comments change appropriately" do
    visit event_path(event)
    page.should have_content "0 comments"

    FactoryGirl.create(:comment, :proposal => proposal)
    FactoryGirl.create(:comment, :proposal => FactoryGirl.create(:proposal, :event => event))

    visit event_path(event)
    page.should have_content "1 comment"
    page.should have_no_content "2 comments"
  end

  scenario "I should be able to see people's comments" do
    FactoryGirl.create(:comment, :proposal => proposal)
    visit event_proposal_path(event, proposal)

    page.should have_content("Lorem Ipsum Dolor")
  end

  scenario "I shouldn't be able to make comments while not logged in" do
    visit event_proposal_path(event, proposal)

    fill_in "comment_body", :with => 'Lorem Ipsum Dolor'
    find('.submit_comment').click

    page.should have_no_content "Comment was successfully created."
    page.should have_content "Login"
  end

  scenario "I should be able to make comments while logged in" do
    sign_in

    visit event_proposal_path(event, proposal)

    fill_in "comment_body", :with => 'Lorem Ipsum Dolor'
    find('.submit_comment').click

    page.should have_no_content "Login"
    page.should have_content 'Lorem Ipsum Dolor'
  end
end
