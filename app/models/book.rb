class Book < ApplicationRecord
  enum status: %i(ready borrowed)

  has_many :book_authors, dependent: :destroy
  has_many :borrows, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :category
  belongs_to :publisher
end
