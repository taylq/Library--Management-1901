class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true
  scope :select_attr, ->{select(:id, :name)}
end
