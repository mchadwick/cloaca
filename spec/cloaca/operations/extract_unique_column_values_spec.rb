require "spec_helper"

describe Cloaca::Operations::ExtractUniqueColumnValues do

  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:result_rows) { result.split("\n") }

  def options(overrides = {})
    {
      column_delimiter: "|",
      input: input,
      output: output,
    }.merge(overrides)
  end

  context "given a single row" do
    let(:input) { StringIO.new([ ["A", "B", "C", "D"].join("|") ].join("\n")) }

    it "can extract the unique values of a column identified by its position" do
      described_class.new(options.merge(index_or_value: 1)).run!
      expect(result_rows.first).to eq("B")
    end

    it "can extract the unique values of a column identified by its value" do
      described_class.new(options.merge(index_or_value: "B")).run!
      expect(result_rows.first).to eq("B")
    end
  end

  context "given multiple rows" do
    let(:input) { StringIO.new([
      ["A", "B1", "C1"].join("|"),
      ["A", "B2", "C2"].join("|"),
      ["A", "B1", "C3"].join("|"),
      ["A", "B2", "C4"].join("|"),
    ].join("\n")) }

    it "can extract the unique values of a column with all duplicates" do
      described_class.new(options.merge(index_or_value: 0)).run!
      expect(result_rows).to eq(%w(A))
    end

    it "can extract the unique values of a column with some duplicate values" do
      described_class.new(options.merge(index_or_value: 1)).run!
      expect(result_rows).to eq(%w(B1 B2))
    end

    it "can extract the unique values of a column with all unique values" do
      described_class.new(options.merge(index_or_value: 2)).run!
      expect(result_rows).to eq(%w(C1 C2 C3 C4))
    end

    it "can extract only the unique values after a given offset" do
      described_class.new(options.merge(index_or_value: 2, row_offset: 2)).run!
      expect(result_rows).to eq(%w(C3 C4))
    end
  end

end
