require File.dirname(__FILE__) + '/acceptance_helper'

feature "Events", %q{
  In order to open call for papers
  As an user
  I want to add events
} do

  context "Viewing events" do
    scenario "While not logged in, I should be able to view events" do
      Factory(:event)
      visit '/events'
      page.should have_content 'GURU-SP'
      page.should have_no_content 'Sign in'
    end

  end

  context "Creating events" do
    scenario "I can create an event" do
      sign_in

      visit '/events'
      find('.create_button').click

      fill_in "Name", :with => 'GURU-SP'
      fill_in 'Description', :with => '50th meeting'
      fill_in 'Occurs at', :with => 1.day.from_now.strftime('%m/%d/%Y')

      find('input[type=image]').click

      page.should have_content "GURU-SP"
    end

    scenario "While not logged in, I should be able to view specific details about an event" do
      event = Factory(:event)

      visit '/events'

      click_link event.name

      page.should have_content 'GURU-SP'
      page.should have_no_content 'Sign in'
    end

    scenario "While registering, I can't register an event without a name" do
      sign_in

      visit '/events'
      find('.create_button').click


      fill_in 'Description', :with => '50th meeting'

      find('input[type=image]').click

      page.should have_content "Name can't be blank"
    end

    scenario "While registering, I can't register an event without a name" do
      sign_in

      visit '/events'
      find('.create_button').click

      fill_in 'Name', :with => 'GURU-SP'

      find('input[type=image]').click

      page.should have_content "Description can't be blank"
    end

    scenario "I should be able to see stats for an event" do
      Factory(:event)
      proposal = Factory(:proposal)
      Factory(:comment, :proposal => proposal)
      2.times { Factory(:vote, :proposal => proposal) }

      visit '/events'

      page.should have_content("1 proposal")
      page.should have_content("1 comment")
      page.should have_content("2 vote")
    end

    scenario "I should be able to see warning if there are no events" do
      visit '/events'
      page.should have_content('There are no events yet. Be the first to create one!')
    end

    scenario "I should be able to go to the list of proposals clicking on the picture" do
      event = Factory(:event)
      visit event_page(event)

      within '#proposal' do
        page.should have_css("a[href*='#{event_page(event)}']")
      end
    end

    scenario "I should be able to create an event with an user registered thru omni auth" do
      pending "How?!"
      # user = User.new
      # user.authentications.build(:uid => '123', :provider => 'twitter')
      # user.save

      # sign_in_with(user)

      # visit '/events'
      # click_link 'New Event'
      # fill_in "Name", :with => 'GURU-SP'
      # fill_in 'Description', :with => '50th meeting'

      # click_button "Create Event"

      # page.should have_content "GURU-SP"
      # page.should have_content 'Event was successfully created.'
    end
  end
end
