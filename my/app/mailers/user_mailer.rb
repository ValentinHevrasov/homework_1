class UserMailer < ApplicationMailer
  def petition_created(petition)
    @petition = petition
    @user = petition.user
    mail to: @user.email, subject: 'Петиция создана!'
  end

  def admin_votes(petition)
    @petition = petition
    @user = petition.user
    @votes = petition.votes
    mail to: "administrator@petitions.com", subject: 'Петиция собрала голоса!'
  end

  def votes_good(petition)
    @petition = petition
    @user = petition.user
    @votes = petition.votes
    mail to: @user.email, subject: 'Петиция собрала голоса!'
  end

  def votes_bad(petition)
    @petition = petition
    @user = petition.user
    @votes = petition.votes
    mail to: @user.email, subject: 'Петиция не собрала голоса!'
  end
end
