class Notification < ApplicationRecord
  belongs_to :user
  after_create_commit :notification

  private

  def notification
    NotificationBroadcastJob.perform_later Notification.count, self
  end
end
