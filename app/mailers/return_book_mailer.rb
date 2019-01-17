class ReturnBookMailer < ApplicationMailer
  def return_book_email user
    @user = user
    mail to: @user.email, subject: t("app.return_book")
  end
end
