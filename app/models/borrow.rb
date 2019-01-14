class Borrow < ApplicationRecord
  enum status: %i(waiting approved disapproved done)

  belongs_to :book
  belongs_to :user

  validates :started_at, presence: true
  validates :finished_at, presence: true
  scope :select_attr, ->{select(:id, :user_id, :book_id, :started_at,
    :finished_at, :status)}
end
