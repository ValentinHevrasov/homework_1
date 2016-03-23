namespace :petition do
  desc "Block old petitions"
  task block_old: :environment do
    # VotingEndingJob.perform_later
    petitions = Petition.where(expired: nil)
    petitions.each do |petition|
      if petition.expired_petition?(petition)
        petition.update(expired: true)
        UserMailer.votes_bad(petition).deliver_later
      end
    end
  end
end
