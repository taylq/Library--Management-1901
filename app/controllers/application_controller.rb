class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def self.default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".please_login"
      redirect_to login_url
    end
  end

  def send_mail_return_book
    Borrow.select_attr.each do |borrow|
      if borrow.finished_at < DateTime.now.tomorrow.to_date
        user = User.find_by id: borrow.user_id
        ReturnBookMailer.return_book_email(user).deliver_now
      end
    end
  end
end
