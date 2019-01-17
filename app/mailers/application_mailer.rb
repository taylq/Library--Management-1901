class ApplicationMailer < ActionMailer::Base
  default from: "not-reply@library.com"
  layout "mailer"
end
