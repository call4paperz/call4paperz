require 'rails_helper'

feature "Comment", %q{
  In order to talk to other people
  As an user
  I want to make comments about proposals
} do

  let(:proposal) { FactoryBot.create(:proposal) }
  let(:event) { proposal.event }

  scenario "I should see the number of comments change appropriately" do
    visit event_path(event)
    expect(page).to have_content "0 comments"

    FactoryBot.create(:comment, :proposal => proposal)
    FactoryBot.create(:comment, :proposal => FactoryBot.create(:proposal, :event => event))

    visit event_path(event)
    expect(page).to have_content "1 comment"
    expect(page).to have_no_content "2 comments"
  end

  scenario "I should be able to see people's comments" do
    FactoryBot.create(:comment, :proposal => proposal)
    visit event_proposal_path(event, proposal)

    expect(page).to have_content("Lorem Ipsum Dolor")
  end

  scenario "I shouldn't be able to make comments while not logged in" do
    visit event_proposal_path(event, proposal)

    expect(page).to_not have_content('.submit_comment')
    expect(page).to have_content(I18n.t('proposals.comments.please_sign_in'))
    expect(page).to have_content('Login')
  end

  scenario "I should be able to make comments while logged in" do
    sign_in

    visit event_proposal_path(event, proposal)

    fill_in "comment_body", :with => 'Lorem Ipsum Dolor'
    find('.submit_comment').click

    expect(page).to have_no_content "Login"
    expect(page).to have_content 'Lorem Ipsum Dolor'
  end
end
