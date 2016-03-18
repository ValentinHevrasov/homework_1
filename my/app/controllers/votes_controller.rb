class VotesController < ApplicationController
  before_filter :authorize

  def create
    vote = current_user.votes.create(petition_params)
    redirect_to vote.petition, notice: 'Проголосовано'
  end

  def petition_params
    params.permit(:petition_id)
  end
end
