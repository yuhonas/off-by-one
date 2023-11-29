# rubocop:disable all
require 'json'
RSpec.describe Shiftcare::CommandRunner do
  describe "#run" do
    let(:data) { JSON.load_file(File.expand_path("./fixtures/clients.json", __dir__)) }
    let(:engine) { Shiftcare::NaiveEngine.new(data) }

    it "dispatches search & it's associated keyword" do
        expect(engine).to receive(:search).with("foo").and_call_original # ensure we're using strict mocks incase the interface changes
        described_class.new(engine).run(search: "foo")
    end

    it "dispatches the duplicates command" do
        expect(engine).to receive(:duplicates).and_call_original # ensure we're using strict mocks incase the interface changes
        described_class.new(engine).run(duplicates: true)
    end
  end
end
