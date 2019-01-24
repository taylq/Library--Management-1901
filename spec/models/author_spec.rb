require "rails_helper"

RSpec.describe Author, type: :model do
  describe "associations" do
    it {is_expected.to have_many :authors_books}
    it {is_expected.to have_many :books}
  end

  describe "validates" do
    describe "#name" do
      subject {FactoryBot.create :author}
      context "when name is presence" do
        it {is_expected.to validate_presence_of :name}
      end

      context "when name is blank" do
        before {subject.name = nil}
        it {expect {raise StandardError}.to raise_error(StandardError)}
      end
    end
  end
end
