class Notification < ApplicationRecord
  belongs_to :user
  after_create_commit :notification

  default_scope -> {order(created_at: :desc)}
  scope :select_attr, ->{select(:id, :user_id, :event, :created_at)}

  private

  def notification
    NotificationBroadcastJob.perform_later Notification.count, self
  end
end
