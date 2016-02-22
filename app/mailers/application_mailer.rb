class ApplicationMailer < ActionMailer::Base
  default from: "admin@codestalk.herokuapp.com"
  layout 'mailer'
end
