module ApplicationHelper
  def full_title title = ""
    base_title = t "layouts.header.home"
    return base_title if title.empty?
    base_title + " | " + title
  end

  def notifications
    Notification.select_attr
  end

  def category_choices
    Category.pluck :name, :id
  end

  def publisher_choices
    Publisher.pluck :name, :id
  end

  def q_params params
    return params[:name_or_content_or_publisher_name_or_authors_name_cont] unless params.nil?
  end
end
