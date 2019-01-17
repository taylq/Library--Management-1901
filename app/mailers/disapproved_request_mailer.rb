class DisapprovedRequestMailer < ApplicationMailer
  def disapproved_request_email user
    @user = user
    mail to: @user.email, subject: t("app.disapproved_request")
  end
end
