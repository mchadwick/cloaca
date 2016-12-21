require "spec_helper"

describe Cloaca::Operations::CheckRowValuesUnique do

  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:result_rows) { result.split("\n") }

  def options(overrides = {})
    {
      case_sensitive: false,
      column_delimiter: "|",
      input: input,
      output: output,
    }.merge(overrides)
  end

  context "given a single row with no duplicates" do
    let(:input) { StringIO.new([ ["A", "B", "C", "D"].join("|") ].join("\n")) }

    it "can do nothing" do
      described_class.new(options).run!
      expect(result_rows.first).to eq("A|B|C|D")
    end
  end

  context "given a single row with duplicates" do
    let(:input) { StringIO.new([ ["A", "B", "B", "C", "C"].join("|") ].join("\n")) }

    it "raises duplicates" do
      subject = described_class.new(options)
      expect { subject.run! }.to raise_exception("duplicate values found: B, C")
    end
  end

  context "given a single row with duplicates differing in case" do
    let(:input) { StringIO.new([ ["A", "B", "C", "c"].join("|") ].join("\n")) }

    it "raises duplicates if case sensitivy is disabled" do
      subject = described_class.new(options.merge(case_sensitive: false))
      expect { subject.run! }.to raise_exception("duplicate value found: C")
    end

    it "does not raise duplicates if case sensitivy is enabled" do
      subject = described_class.new(options.merge(case_sensitive: true)).run!
      expect(result_rows.first).to eq("A|B|C|c")
    end
  end

  context "given a single row with a conflicting integer and string" do
    let(:input) { StringIO.new([ [1, "1"].join("|") ].join("\n")) }

    it "raises the duplicate" do
      subject = described_class.new(options)
      expect { subject.run! }.to raise_exception("duplicate value found: 1")
    end
  end

  context "given multiple columns" do
    let(:input) { StringIO.new([
      ["A1", "A1", "C1", "D1"].join("|"),
      ["A2", "B1", "C2", "A2"].join("|"),
      ["A3", "B3", "C3", "D3"].join("|"),
    ].join("\n")) }

    it "raises duplicates if the specified row contains duplicates" do
      subject = described_class.new(options.merge(index: 0))
      expect { subject.run! }.to raise_exception("duplicate value found: A1")
    end

    it "strips the newline off the last column" do
      subject = described_class.new(options.merge(index: 1))
      expect { subject.run! }.to raise_exception("duplicate value found: A2")
    end

    it "can do nothing if the specified row does not contain duplicates" do
      described_class.new(options.merge(index: 2)).run!
      expect(result_rows.last).to eq("A3|B3|C3|D3")
    end
  end

end
