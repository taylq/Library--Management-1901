require "ffaker"

FactoryBot.define do
  factory :author do |a|
    a.name {FFaker::Name.name}
    a.note {FFaker::Name.name}
  end
end
