require "rails_helper"

RSpec.describe Book, type: :model do
  describe "associations" do
    it {is_expected.to have_many :authors_books}
    it {is_expected.to have_many :authors}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :borrows}
    it {is_expected.to have_many :like_books}
    it {is_expected.to have_many :follow_books}

    it {is_expected.to belong_to :category}
    it {is_expected.to belong_to :publisher}
  end

  describe "validates" do
    subject {FactoryBot.create :book}

    describe "#name" do
      context "when name is presence" do
        it {is_expected.to validate_presence_of :name}
      end

      context "when name is blank" do
        before {subject.name = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end

    describe "#category" do
      context "when category is presence" do
        it {is_expected.to validate_presence_of :category_id}
      end

      context "when category is blank" do
        before {subject.category_id = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end

    describe "#publisher" do
      context "when publisher is presence" do
        it {is_expected.to validate_presence_of :publisher_id}
      end

      context "when publisher is blank" do
        before {subject.publisher_id = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end

    describe "#number_of_page" do
      context "when number_of_page is presence" do
        it {is_expected.to validate_presence_of :number_of_page}
      end

      context "when number_of_page is blank" do
        before {subject.number_of_page = nil}
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

      it { should define_enum_for(:status).with_values([:ready, :borrowed])}
    end
  end
end
