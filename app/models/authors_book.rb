class AuthorsBook < ApplicationRecord
  belongs_to :author
  belongs_to :book

  delegate :name, :note, to: :author
end
