class UserMailer < ApplicationMailer
  def petition_created(petition)
    @petition = petition
    @user = petition.user
    mail to: @user.email, subject: 'Petition created'
  end
end
