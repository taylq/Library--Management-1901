class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all.reverse
  end

  def new
    @new_notification = current_uder.notifications.new
    render layout: false
  end

  def create
    @notification = current_uder.notifications.new event_params
    if @notification.save
      flash[:success] = "Create success."
      redirect_to new_notification_path
    end
  end

  private

  def event_params
    params.require(:notification).permit :event, :user_id
  end
end
