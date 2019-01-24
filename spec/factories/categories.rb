require "ffaker"

FactoryBot.define do
  factory :category do |ca|
    ca.name {FFaker::Name.name}
  end
end
