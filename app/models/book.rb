class Book < ApplicationRecord
  ratyrate_rateable "like", "good"
  enum status: %i(ready borrowed)

  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books, dependent: :destroy
  has_many :borrows, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follow_books, dependent: :destroy
  has_many :like_books, dependent: :destroy

  belongs_to :category
  belongs_to :publisher
  default_scope -> {order(created_at: :desc)}
  scope :select_attr, ->{select(:id, :category_id, :publisher_id, :name, :content, :number_of_page, :status, :image)}
  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :authors_books, allow_destroy: true,
    reject_if: proc{|attributes| attributes["author_id"] == "0"}

  delegate :name, :phone, :address, to: :publisher, prefix: true
  delegate :name, to: :category, prefix: true

  class << self
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
