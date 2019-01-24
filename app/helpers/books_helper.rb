module BooksHelper
  def status_choice
    Book.statuses.keys.map{|status| [t("#{status}"), status]}
  end
end
