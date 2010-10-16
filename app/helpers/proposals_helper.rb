module ProposalsHelper
  def vote_box(event, proposal, user)
    if user && user.has_vote_for?(proposal)
      "You've already voted"
    else
      content = ''
      content << link_to('+', like_event_proposal_path(event, proposal))
      content << link_to('-', dislike_event_proposal_path(event, proposal))
      content.html_safe
    end
  end
end
