class ReturnBookJob < ApplicationJob
  def perform
    Borrow.status_approved.each do |borrow|
      ReturnBookMailer.delay.return_book_email borrow.user
    end
  end
end
