module BorrowsHelper
  def status_choice
    Borrow.statuses.keys.map{|status| [t("#{status}"), status]}
  end
end
