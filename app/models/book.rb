class Book < ApplicationRecord
  enum status: %i(ready borrowed)

  has_many :book_authors, dependent: :destroy
  has_many :borrows, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follow_books, dependent: :destroy
  has_many :like_books, dependent: :destroy

  belongs_to :category
  belongs_to :publisher
  default_scope -> {order(created_at: :desc)}
  scope :select_attr, ->{select(:id, :category_id, :publisher_id, :name, :content, :number_of_page, :status, :image)}
  scope :search_scope, ->(search) do
    joins(:publisher, authors_books: :author)
    .where "books.name like '%#{search}%' or books.content like '%#{search}%' or publishers.name like '%#{search}%' or authors.name like '%#{search}%'"
  end

  delegate :name, :phone, :address, to: :publisher, prefix: true
  delegate :name, to: :category, prefix: true

  class << self
    def search search
      if search
        search_scope search
      else
        Book.select_attr
      end
    end

    def to_csv
      CSV.generate do |csv|
        attributes = %w{id name category_id publisher_id content number_of_page status}
        csv << attributes
        all.each do |book|
          csv << book.attributes.values_at(*attributes)
        end
      end
    end
  end
end
