class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :content, presence: true
  delegate :name, :gravatar_url, to: :user

  scope :order_comment, -> {order(created_at: :desc)}
end
