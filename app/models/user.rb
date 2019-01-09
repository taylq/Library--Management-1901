class User < ApplicationRecord
  enum role: %i(user admin)

  has_many :borrows, dependent: :destroy
  has_many :comments, dependent: :destroy
end
