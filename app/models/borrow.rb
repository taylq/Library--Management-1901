class Borrow < ApplicationRecord
  after_create_commit :notify
  enum status: %i(waiting approved disapproved done)

  belongs_to :book
  belongs_to :user

  validates :started_at, presence: true
  validates :finished_at, presence: true


  private

  def notify
    Notification.create event: "#{user.name} send request to borrow book", user_id: user.id
  end
end
