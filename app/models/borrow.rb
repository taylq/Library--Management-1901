class Borrow < ApplicationRecord
  enum status: %i(waiting approved disapproved done)

  belongs_to :book
  belongs_to :user
end
