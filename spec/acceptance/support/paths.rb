module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def event_page(event)
    "/events/#{event.slug.name}"
  end

  def proposal_page(proposal)
    "/events/#{proposal.event.slug}/proposals/#{proposal.id}"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
