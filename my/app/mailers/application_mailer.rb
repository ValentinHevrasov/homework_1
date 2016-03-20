class ApplicationMailer < ActionMailer::Base
  default from: "administrator@petitions.com"
  layout 'mailer'
end
