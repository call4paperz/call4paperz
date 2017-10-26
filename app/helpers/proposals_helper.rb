module ProposalsHelper

  def proposal_user(proposal)
    if @users.present?
      @users[proposal.user_id]
    else
      proposal.user
    end
  end

end
