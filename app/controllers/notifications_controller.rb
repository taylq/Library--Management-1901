class NotificationsController < ApplicationController
  def index
    @notifications = Notification.select_attr
  end

  def new
    @new_notification = current_user.notifications.new
  end

  def create
    @notification = current_user.notifications.new event_params
    if @notification.save
      flash[:success] = t ".create_success"
      redirect_to new_notification_path
    else
      redirect_to root_path
      flash[:danger] = t ".create_fail"
    end
  end

  private

  def event_params
    params.require(:notification).permit :event, :user_id
  end
end
