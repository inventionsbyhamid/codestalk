class ApplicationMailer < ActionMailer::Base
  default from: "CodeStalk <admin@codestalk.herokuapp.com>"
  layout 'mailer'
end
