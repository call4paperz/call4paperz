require 'spec_helper'

feature "Vote", %q{
  In order to express my opinion
  As an user
  I want to vote positively or negatively on a proposal
} do

  let(:proposal) { FactoryBot.create(:proposal) }
  let(:event) { proposal.event }


  scenario "While not logged in, I should not be able to like a proposal" do
    visit event_path(event)

    click_like

    expect(page).to have_content("Login")
  end

  scenario "After trying to vote not logged in, and logging in, the vote should be computed automatically" do
    visit event_path(event)

    click_like

    expect(page).to have_content("Login")

    sign_in_from_login_page
    expect(page).to have_content("You liked the proposal.")
  end

  scenario "While not logged in, I should not be able to dislike a proposal" do
    visit event_path(event)

    click_dislike
    expect(page).to have_content("Login")
  end

  scenario "While logged in, I should be able to like a proposal" do
    sign_in

    visit event_path(event)

    click_like
    expect(page).to have_no_content("Login")
  end

  scenario "While logged in, I should be able to dislike a proposal" do
    sign_in

    visit event_path(event)

    click_dislike
    expect(page).to have_no_content("Login")
  end

  scenario "While I've already voted, I should be notified that I can't vote again" do
    sign_in

    visit event_path(event)

    click_like
    expect(page).to have_css("img[alt='Thanks for voting!']")
  end

  def click_like
    find("a[href*='/like']").click
  end

  def click_dislike
    find("a[href*=dislike]").click
  end
end
