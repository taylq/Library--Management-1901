require "ffaker"

FactoryBot.define do
  factory :borrow do |b|
    book
    user
    b.started_at {FFaker::Time.datetime}
    b.finished_at {FFaker::Time.datetime}
    b.status {0}
  end
end
