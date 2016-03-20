namespace :petition do
  desc "Deleting old petitions"
  task check_old: :environment do
  	p '________________starting deleting old petitions'
    petition = Petition.first
    petition.destroy!
    # Rails.logger.info 'destroyed! id: ' + petition.id.to_s
    p '________________destroyed! id: ' + petition.id.to_s
  end

end
