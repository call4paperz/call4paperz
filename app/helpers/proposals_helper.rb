module ProposalsHelper
  def vote_box(event, proposal, user)
    if user && user.has_vote_for?(proposal)
      image_tag('checked.png', :alt => 'Thanks for voting!').html_safe
    else
      content = ''
      ajax_class = {:class => "ajax_vote"} if user
      content << link_to(image_tag('positive.png', :class => 'thumb thumb_p'), like_event_proposal_path(event, proposal), ajax_class)
      content << link_to(image_tag('negative.png', :class => 'thumb'), dislike_event_proposal_path(event, proposal), ajax_class)
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
      content_tag :div, :class => "#{klass}", :style => "width: #{percentage}%" do
        content_tag :span, number_to_percentage(percentage, :precision => 0)
      end
    end
  end
end
