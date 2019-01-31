class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  scope :select_attr, ->{select(:id, :name)}
  scope :search_scope, ->(search){where "name like '%#{search}%'"}
  scope :order_comment, -> {order(created_at: :desc)}

  class << self
    def search search
      if search
        search_scope search
      else
        Category.select_attr
      end
    end
  end
end
