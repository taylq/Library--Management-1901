class Book < ApplicationRecord
  enum status: %i(ready borrowed)

  has_many :book_authors, dependent: :destroy
  has_many :borrows, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :category
  belongs_to :publisher
  default_scope -> {order(created_at: :desc)}
  scope :select_attr, ->{select(:id, :category_id, :publisher_id, :name, :content, :number_of_page, :status, :image)}
  scope :search_scope, ->(search) do
    joins(:publisher, book_authors: :author)
    .where "books.name like '%#{search}%' or books.content like '%#{search}%' or publishers.name like '%#{search}%' or authors.name like '%#{search}%'"
  end

  class << self
    def search search
      if search
        search_scope search
      else
        Book.select_attr
      end
    end
  end
end
