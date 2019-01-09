class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
end
