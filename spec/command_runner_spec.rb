# rubocop:disable all
require 'json'
RSpec.describe Shiftcare::CommandRunner do
  describe "#run" do
    let(:data) { JSON.load_file(File.expand_path("./fixtures/clients.json", __dir__)) }
    let(:explorer) { Shiftcare::NaiveExplorer.new(data) }

    it "dispatches search & it's associated keyword" do
        expect(explorer).to receive(:search).with("foo").and_call_original # ensure we're using strict mocks incase the interface changes
        described_class.new(explorer).run(search: "foo")
    end

    it "dispatches the duplicates command" do
        expect(explorer).to receive(:duplicates).and_call_original # ensure we're using strict mocks incase the interface changes
        described_class.new(explorer).run(duplicates: true)
    end
  end
end
