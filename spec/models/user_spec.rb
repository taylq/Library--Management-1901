require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it {is_expected.to have_many :borrows}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :active_relationships}
    it {is_expected.to have_many :passive_relationships}
    it {is_expected.to have_many :following}
    it {is_expected.to have_many :followers}
    it {is_expected.to have_many :follow_books}
    it {is_expected.to have_many :like_books}
    it {is_expected.to have_many :notifications}
  end

  describe "validates" do
    describe "#name" do
      subject {FactoryBot.create :user}
      context "when name is presence" do
        it {is_expected.to validate_presence_of :name}
      end

      context "when name is at most 50 char" do
        it {is_expected.to validate_length_of(:name).is_at_most(50)}
      end

      context "when name is blank" do
        before {subject.name = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end

    describe "#email" do
      subject {FactoryBot.create :user}
      context "when email is presence" do
        it {is_expected.to validate_presence_of :email}
      end

      context "when email is at most 255 char" do
        it {is_expected.to validate_length_of(:email).is_at_most(255)}
      end

      context "when email is uniqueness" do
        it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
      end

      context "when email is formated" do
        it {is_expected.to allow_value("a@b.com").for(:email)}
      end

      context "when email is blank" do
        before {subject.email = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end

      context "when email is Malformed" do
        before {subject.email = "blah"}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end

    describe "#password" do
      subject {FactoryBot.create :user}

      context "when password is at least 6 char" do
        it {is_expected.to validate_length_of(:password).is_at_least(6)}
      end

      context "when password is blank" do
        before {subject.password = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end

      context "when password less than 6 characters" do
        before {subject.password = "blah"}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end
  end
end
