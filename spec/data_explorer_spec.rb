# rubocop:disable all
RSpec.describe Shiftcare::DataExplorer do
  let(:explorer) { described_class.new(data) }
  let(:data) { JSON.load_file(File.expand_path("./fixtures/clients.json", __dir__)) }

  describe "#search" do
    it "returns the first matching record by full_name" do
      expect(explorer.search("john").fetch("full_name")).to eq("John Doe")
    end

    it "returns an empty hash if given a full_name that doesnt exist" do
      expect(explorer.search("omniman")).to eq({})
    end
  end

  describe "#duplicates" do
    subject { explorer.duplicates }

    context "when there are duplicate emails" do
      it { is_expected.to include( {"id"=>2, "full_name"=>"Jane Smith", "email"=>"jane.smith@yahoo.com"}) }
      it { is_expected.to include( {"id"=>15, "full_name"=>"Another Jane Smith", "email"=>"jane.smith@yahoo.com"}  ) }

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
