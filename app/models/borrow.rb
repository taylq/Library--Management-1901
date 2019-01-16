class Borrow < ApplicationRecord
  after_create_commit :notify
  enum status: %i(waiting approved disapproved done)

  belongs_to :book
  belongs_to :user

  validates :started_at, presence: true
  validates :finished_at, presence: true
  scope :select_attr, ->{select(:id, :user_id, :book_id, :started_at,
    :finished_at, :status)}

  private

  def notify
    Notification.create event: I18n.t("borrows.request", user_name: user.name), user_id: user.id
  end
end
