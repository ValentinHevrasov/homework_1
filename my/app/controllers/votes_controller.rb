class VotesController < ApplicationController
  before_filter :authorize_user

  def create
    vote = current_user.votes.create(petition_params)
      petition_votes = Vote.where(petition_params).count
    if petition_votes = Vote::VOTES
      petition = vote.petition
      UserMailer.admin_votes(petition).deliver_later
      UserMailer.votes_good(petition).deliver_later
      # petition.update(expired: false)
    end
    redirect_to vote.petition, notice: 'Проголосовано'
  end

  def petition_params
    params.permit(:petition_id)
  end
end
