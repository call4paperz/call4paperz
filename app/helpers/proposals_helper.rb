module ProposalsHelper

  def proposal_user(proposal)
    if @users.present?
      @users[proposal.user_id]
    else
      proposal.user
    end
  end

  def vote_box(event, proposal, user)
    if user && user.has_vote_for?(proposal)
      image_tag('checked.png', :alt => 'Thanks for voting!').html_safe
    else
      content = ''
      ajax_class = {:class => "ajax_vote"} if user
      content << link_to(image_tag('positive.png', :class => 'thumb thumb_p'), like_event_proposal_path(event, proposal), ajax_class || {})
      content << link_to(image_tag('negative.png', :class => 'thumb'), dislike_event_proposal_path(event, proposal), ajax_class || {})
      content.html_safe
    end
  end

  def render_percentage_bar(percentage)
    if percentage == 50.0
      klass = 'gray'
    elsif percentage > 0
      klass = 'green'
    else
      klass = 'red'
      percentage = percentage.abs
    end

    content_tag :div, :class => 'percentage' do
      content_tag :div, :class => "#{klass}", :style => "width: #{percentage_bar_width(percentage)}px" do
        content_tag :span, percentage
      end
    end
  end

  private
    PERCENTAGE_BAR_MAX_WIDTH = 200 # In pixels

    def percentage_bar_width(value)
      value * PERCENTAGE_BAR_MAX_WIDTH / 100
    end
end

