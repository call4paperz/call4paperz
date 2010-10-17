module ProposalsHelper
  def vote_box(event, proposal, user)
    if user && user.has_vote_for?(proposal)
      "Thanks for voting!"
    else
      content = ''
      content << link_to(image_tag('positive.png', :class => 'thumb thumb_p'), like_event_proposal_path(event, proposal), {:remote => true, :class => "ajax_vote"})
      content << link_to(image_tag('negative.png', :class => 'thumb'), dislike_event_proposal_path(event, proposal), {:remote => true, :class => "ajax_vote"})
      content.html_safe
    end
  end
end
