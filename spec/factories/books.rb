require "ffaker"

FactoryBot.define do
  factory :book do |b|
    category
    publisher
    b.name {FFaker::Name.name}
    b.content {FFaker::Name.name}
    b.number_of_page {12}
    b.status {0}
  end
end
