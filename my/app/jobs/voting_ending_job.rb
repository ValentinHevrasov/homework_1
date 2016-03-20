class VotingEndingJob < ActiveJob::Base
  queue_as :default

  # def perform
  #   petitions = Petition.where(expired: nil)
  #   petitions.each do |petition|
  #     if petition.expired_petition?(petition)
  #       petition.update(expired: true)
  #       UserMailer.votes_bad(petition).deliver_later
  #     end
  #   end
  # end
end
