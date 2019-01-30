class Author < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :books, through: :authors_books, dependent: :destroy

  validates :name, presence: true

  scope :select_attr, ->{select(:id, :name, :note)}

  def author_ids_of_book book_id
    return if authors_books.find_by(book_id: book_id)
  end
end
