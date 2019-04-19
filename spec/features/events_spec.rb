require 'rails_helper'

feature "Events", %q{
  In order to open call for papers
  As an user
  I want to add events
} do

  context "Viewing events" do
    scenario "While not logged in, I should be able to view events" do
      FactoryBot.create(:event)
      visit '/events'
      expect(page).to have_content 'GURU-SP'
      expect(page).to have_no_content 'Sign in'
    end
  end

  context "Viewing tagged events" do
    scenario "While not logged in, I should be able to view events" do
      FactoryBot.create(:event)
      FactoryBot.create(:event, :ruby, name: 'RubyOnRio')

      visit '/events/tags/ruby'
      expect(page).to have_content 'RubyOnRio'
      expect(page).to have_no_content 'GURU-SP'
      expect(page).to have_no_content 'Sign in'
    end
  end

  context "Creating events" do
    scenario "I can create an event" do
      sign_in

      visit '/events'
      find('.create_button').click

      fill_in "event_name",            with: 'GURU-SP'
      fill_in 'event_description',     with: '50th meeting'
      fill_in 'event_occurs_at',       with: 1.day.from_now.strftime('%Y-%m-%d')

      # save_and_open_page
      find(:css, 'input[type*="image"]').click
      
      expect(page).to have_content "GURU-SP"
    end

    scenario "While not logged in, I should be able to view specific details about an event" do
      event = FactoryBot.create(:event)

      visit '/events'

      click_link event.name

      expect(page).to have_content 'GURU-SP'
      expect(page).to have_no_content 'Sign in'
    end

    context 'Registering' do
      scenario "I can't register an event without a name" do
        sign_in

        visit '/events'
        find('.create_button').click


        fill_in 'Description', :with => '50th meeting'

        find('input[type=image]').click

        expect(page).to have_content "Name can't be blank"
      end

      scenario "I can't register an event without a name" do
        sign_in

        visit '/events'
        find('.create_button').click

        fill_in 'Name', :with => 'GURU-SP'

        find('input[type=image]').click

        expect(page).to have_content "Description can't be blank"
      end
    end

    scenario "I should be able to see stats for an event" do
      FactoryBot.create(:event)
      proposal = FactoryBot.create(:proposal)
      FactoryBot.create(:comment, :proposal => proposal)
      2.times { FactoryBot.create(:vote, :proposal => proposal) }

      visit '/events'

      expect(page).to have_content("1 proposal")
      expect(page).to have_content("1 comment")
      expect(page).to have_content("2 vote")
    end

    scenario "I should be able to see the events sorted by the date the events occur" do
      Timecop.freeze(2.days.ago)

      past_event = FactoryBot.create(:event, :occurs_at => Time.current, :name => 'The Dinosaurs')
      todays_event = FactoryBot.create(:event, :occurs_at => 2.days.from_now, :name => 'Groundhog Day')
      late_event = FactoryBot.create(:event, :occurs_at => 10.days.from_now, :name => 'Late show')
      early_event = FactoryBot.create(:event, :occurs_at => 5.day.from_now, :name => 'Good morning Vietnam')

      Timecop.return

      visit '/events'

      within(:xpath, "//li[@class='event_listed'][1]") do
        expect(page).to have_content('Groundhog Day')
      end

      within(:xpath, "//li[@class='event_listed'][2]") do
        expect(page).to have_content('Good morning Vietnam')
      end

      within(:xpath, "//li[@class='event_listed'][3]") do
        expect(page).to have_content('Late show')
      end
    end

    scenario "I should be able to see warning if there are no events" do
      visit '/events'
      expect(page).to have_content('There are no events yet. Be the first to create one!')
    end

    scenario "I should be able to go to the list of proposals clicking on the picture" do
      event = FactoryBot.create(:event)
      visit event_path(event)

      within '#proposal' do
        expect(page).to have_css("a[href*='#{event_path(event)}']")
      end

      expect(page).to have_no_content 'Administrative tools'
      expect(page).to have_no_content 'Speakers contacts'
    end

    context "I am the owner" do
      let(:user) { FactoryBot.create :user }
      let(:event) { FactoryBot.create :event, user: user }

      background do
        sign_in_with(user)
      end

      scenario "I should be able to see admin links" do
        visit event_path(event)

        expect(page).to have_content 'Administrative tools'
        expect(page).to have_content 'Edit event'
        expect(page).to have_content 'Crop picture'
        expect(page).to have_content 'Speakers contacts'
      end

      scenario "I should be able to see admin links for events with proposal" do
        event = FactoryBot.create :event, user: user
        FactoryBot.create :proposal, event: event

        visit event_path(event)

        expect(page).to have_content "Administrative tools"
        expect(page).to have_content "Edit event"
        expect(page).to have_content "Crop picture"
      end
    end

    scenario "I should be able to edit an event" do
      user = FactoryBot.create(:user)
      sign_in_with(user)

      event = FactoryBot.create(:event, :user => user)

      visit edit_event_path(event)
      fill_in 'Occurs at', :with => '2011-01-20'

      find(".actions input").click
      expect(page).to have_content "Event was successfully updated."
    end

    scenario "I should be able to create an event with an user registered thru omni auth" do
      auth = Authentication.new provider: 'twitter', uid: '123'
      auth.auth_info = { 'email' => 'lol@example.org' }
      User.find_or_create_with_authentication auth

      sign_in_via_twitter('123')

      visit '/events'
      find('.create_button').click

      fill_in "Name", :with => 'GURU-SP'
      fill_in 'Description', :with => '50th meeting'
      fill_in 'Occurs at', :with => 1.day.from_now.strftime('%Y-%m-%d')

      find('input[type=image]').click

      expect(page).to have_content "GURU-SP"
      expect(page).to have_content 'Event was successfully created.'
    end
  end

  context "Editing events" do
    scenario "I should be able to edit an event" do
      user = FactoryBot.create(:user)
      sign_in_with(user)

      event = FactoryBot.create(:event, :user => user)

      visit event_path(event)

      click_on "Close for new proposals"

      expect(page).to have_content "Are you sure you want to close the event for new proposals?"
      click_on "Yes, close for new proposals"

      expect(page).to have_content "This event is now closed for new proposals"
      expect(page).to have_content "This event is not accepting new proposals."

      within '#proposal' do
        expect(page).to have_no_css("a[href*='#{new_event_proposal_path(event)}']")
      end

      click_on "Open for new proposals"
      expect(page).to have_content "Are you sure you want to open the event for new proposals?"
      click_on "Yes, open for new proposals"

      expect(page).to have_content "This event is now open for new proposals."
      expect(page).to have_no_content "This event is not accepting new proposals."
    end
  end
end
