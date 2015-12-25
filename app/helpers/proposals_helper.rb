module ProposalsHelper

  def proposal_user(proposal)
    if @users.present?
      @users[proposal.user_id]
    else
      proposal.user
    end
  end

  def vote_box(event, proposal, user)
    if user&.has_vote_for?(proposal)
      image_tag('checked.png', :alt => 'Thanks for voting!').html_safe
    else
      content = ''
      ajax_class = {:class => "ajax_vote"} if user
      content << link_to(image_tag('positive.png', :class => 'thumb thumb_p'), like_event_proposal_path(event, proposal), ajax_class || {})
      content << link_to(image_tag('negative.png', :class => 'thumb'), dislike_event_proposal_path(event, proposal), ajax_class || {})
      content.html_safe
    end
  end

  def render_votes_bar(votes_count)
    if votes_count == 50.0
      klass = 'gray'
    elsif votes_count > 0
      klass = 'green'
    else
      klass = 'red'
      votes_count = votes_count.abs
    end

    content_tag :div, :class => 'percentage' do
      content_tag :div, :class => "#{klass}", :style => "width: #{votes_bar_width(votes_count)}px" do
        content_tag :span, votes_count
      end
    end
  end

  private
    VOTES_BAR_MAX_WIDTH = 200 # In pixels
    LIMIT = 100

    def votes_bar_width(value)
      if value >= LIMIT
        VOTES_BAR_MAX_WIDTH
      else
        value * VOTES_BAR_MAX_WIDTH / LIMIT
      end
    end
end
