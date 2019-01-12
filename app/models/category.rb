class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  scope :select_attr, ->{select(:id, :name)}
end
