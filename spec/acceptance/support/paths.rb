module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def event_page(event)
    "/events/#{event.id}"
  end

  def proposal_page(proposal)
    "/events/#{proposal.event.id}/proposals/#{proposal.id}"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
