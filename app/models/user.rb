class User < ApplicationRecord
  before_save :email_downcase
  enum role: %i(user admin)

  has_many :borrows, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :follow_books, dependent: :destroy
  has_many :like_books, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}

  default_scope -> {order(created_at: :desc)}
  scope :select_attr, ->{select(:id, :name, :email, :role)}
  scope :search_scope, ->(search){where "name like '%#{search}%' or email like '%#{search}%'"}

  has_secure_password

  def gravatar_url options = {size: 50}
    gravatar_id = Digest::MD5.hexdigest email.downcase
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def search search
      if search
        search_scope search
      else
        User.select_attr
      end
    end
  end

  def feed
    Book.where "category_id IN (SELECT category_id FROM books JOIN follow_books
      ON books.id = follow_books.book_id WHERE follow_books.user_id = ?)", id
  end

  def categories_of_feed
    Category.where "id IN (SELECT category_id FROM books JOIN follow_books
      ON books.id = follow_books.book_id WHERE follow_books.user_id = ?)", id
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def liking? book
    like_books.include? book
  end

  private

  def email_downcase
    email.downcase!
  end
end
