require "rails_helper"

RSpec.describe Borrow, type: :model do
  describe "associations" do
    it {is_expected.to belong_to :book}
    it {is_expected.to belong_to :user}
  end

  describe "validates" do
    subject {FactoryBot.create :borrow}

    describe "#book" do
      context "when book is presence" do
        it {is_expected.to validate_presence_of :book_id}
      end

      context "when book is blank" do
        before {subject.book_id = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end

    describe "#user" do
      context "when user is presence" do
        it {is_expected.to validate_presence_of :user_id}
      end

      context "when user is blank" do
        before {subject.user_id = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end

    describe "#started_at" do
      context "when started_at is presence" do
        it {is_expected.to validate_presence_of :started_at}
      end

      context "when started_at is blank" do
        before {subject.started_at = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end

    describe "#finished_at" do
      context "when finished_at is presence" do
        it {is_expected.to validate_presence_of :finished_at}
      end

      context "when finished_at is blank" do
        before {subject.finished_at = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end

    describe "#status" do
      context "when status is presence" do
        it {is_expected.to validate_presence_of :status}
      end

      context "when status is blank" do
        before {subject.status = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end

      it { should define_enum_for(:status).with_values([:waiting, :approved, :disapproved, :done])}
    end
  end
end
