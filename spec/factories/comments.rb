require "ffaker"

FactoryBot.define do
  factory :comment do |c|
    c.content {FFaker::Name.name}
  end
end
