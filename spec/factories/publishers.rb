require "ffaker"

FactoryBot.define do
  factory :publisher do |p|
    p.name {FFaker::Name.name}
    p.phone {FFaker::PhoneNumber.phone_number}
    p.address {FFaker::Address.city}
  end
end
