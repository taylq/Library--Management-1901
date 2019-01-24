require "ffaker"

FactoryBot.define do
  factory :user do |u|
    u.name {FFaker::Name.name}
    u.email {FFaker::Internet.email}
    u.password {"foobar"}
    u.password_confirmation {"foobar"}
  end
end
