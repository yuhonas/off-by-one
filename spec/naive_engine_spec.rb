# rubocop:disable all
RSpec.describe Shiftcare::NaiveEngine do
  let(:engine) { described_class.new(data) }
  let(:data) do
    [
      { "full_name" => "John Smith",   "email" => "test@example.com" },
      { "full_name" => "Robert Smith", "email" => "test@example.com" },
      { "full_name" => "Jason Doe",    "email" => "doe@example.com" }
    ]
  end

  describe "#search" do
    it "returns the first matching record by full_name" do
      expect(engine.search("john").fetch("full_name")).to eq("John Smith")
    end

    it "returns an empty hash if given a full_name that doesnt exist" do
      expect(engine.search("jane")).to eq({})
    end
  end

  describe "#duplicates" do
    subject { engine.duplicates }

    context "when there are duplicate emails" do
      it { is_expected.to include( { "full_name" => "John Smith", "email" => "test@example.com" }) }
      it { is_expected.to include( { "full_name" => "Robert Smith", "email" => "test@example.com" }) }
      it { expect(subject.size).to eq(2) }
    end

    context "when there are no duplicate emails" do
      let(:data) do
        [
          { "full_name" => "John Smith",   "email" => "john@example.com" },
          { "full_name" => "Robert Smith", "email" => "robert@example.com" }
        ]
      end

      it { is_expected.to be_empty }
    end
  end
end
