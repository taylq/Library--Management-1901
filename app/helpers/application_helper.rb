module ApplicationHelper
  def full_title title = ""
    base_title = t "layouts.header.home"
    return base_title if title.empty?
    base_title + " | " + title
  end

  def notifications
    Notification.select_attr
  end
end
