module ProposalsHelper
  def vote_box(proposal, user)
    if user.has_vote_for?(proposal)
      "Já votou campeao"
    else
      content = ''
      content << link_to('+', like_event_proposal_path(@event, proposal))
      content << link_to('-', dislike_event_proposal_path(@event, proposal))
      content.html_safe
    end
  end
end
