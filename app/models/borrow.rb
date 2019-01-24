class Borrow < ApplicationRecord
  after_create_commit :notify
  enum status: %i(waiting approved disapproved done)

  belongs_to :book
  belongs_to :user

  validates :started_at, presence: true
  validates :finished_at, presence: true
  validates :book_id, presence: true
  validates :user_id, presence: true
  validates :status, presence: true
  validate :validate_time, on: :create
  delegate :name, to: :user, prefix: true
  delegate :name, to: :book, prefix: true

  scope :select_attr, ->{select(:id, :user_id, :book_id, :started_at,
    :finished_at, :status)}
  scope :find_by_status, ->(book_id, finished_at){
    where "started_at < ? and book_id = ? and status = ?", finished_at, book_id, Settings.waiting
  }
  scope :search_scope, ->(status, search){
    joins(:book, :user).where(status: "#{status}")
    .where("books.name like '%#{search}%' or users.name like '%#{search}%'")
  }
  scope :check_record, ->(user_id, book_id){where user_id: user_id, book_id: book_id, status: [:waiting] }
  scope :status_approved, ->{where(status: [:approved]).where("finished_at < ?", DateTime.now)}

  class << self
    def search search, status
      if search
        search_scope search, status
      else
        Borrow.select_attr
      end
    end
  end

  private

  def notify
    Notification.create event: I18n.t("borrows.request", user_name: user.name), user_id: user.id
  end

  def validate_time
    errors.add(:started_at, "can't be in the past") unless started_at > DateTime.now
    errors.add(:started_at, "can't be > finished_at") unless started_at < finished_at
  end
end
