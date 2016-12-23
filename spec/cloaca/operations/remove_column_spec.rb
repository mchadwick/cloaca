require "spec_helper"

describe Cloaca::Operations::RemoveColumn do

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

    it "can remove a column identified by its position" do
      described_class.new(options.merge(index_or_value: 0)).run!
      expect(result_rows.first).to eq("B|C|D")
    end

    it "can remove a column indentified by its value" do
      described_class.new(options.merge(index_or_value: "B")).run!
      expect(result_rows.first).to eq("A|C|D")
    end

    it "can remove a column identified by its negative position" do
      described_class.new(options.merge(index_or_value: -1)).run!
      expect(result_rows.first).to eq("A|B|C")
    end

    it "ignores a column which cannot be found by position" do
      described_class.new(options.merge(index_or_value: 9)).run!
      puts "HI"
      puts result_rows.inspect
      expect(result_rows.first).to eq("A|B|C|D")
    end

    it "ignores a column which cannot be found by its value" do
      described_class.new(options.merge(index_or_value: "Z")).run!
      expect(result_rows.first).to eq("A|B|C|D")
    end
  end

  context "given multiple rows with an unequal column count" do
    let(:input) { StringIO.new([
      ["A1", "B1", "C1", "D1"].join("|"),
      ["A2", "B2", "C2"].join("|"),
      ["A3", "B3", "C3"].join("|"),
      ["A4", "B4", "C4"].join("|"),
    ].join("\n")) }

    it "can remove a column identified by its position (and thus correct the unequal column count)" do
      described_class.new(options.merge(index_or_value: 3)).run!
      expect(result).to eq(collapse("
        A1|B1|C1
        A2|B2|C2
        A3|B3|C3
        A4|B4|C4"))
    end

    it "can remove a column indentified by its value" do
      described_class.new(options.merge(index_or_value: "B1")).run!
      expect(result).to eq(collapse("
        A1|C1|D1
        A2|C2
        A3|C3
        A4|C4"))
    end
  end

  context "given multiple rows with an equal column count" do
    let(:input) { StringIO.new([
      ["A1", "B1", "C1", "D1"].join("|"),
      ["A2", "B2", "C2", "D2"].join("|"),
      ["A3", "B3", "C3", "D3"].join("|"),
      ["A4", "B4", "C4", "D4"].join("|"),
    ].join("\n")) }

    it "can remove a column identified by its position" do
      described_class.new(options.merge(index_or_value: 2)).run!
      expect(result).to eq(collapse("
        A1|B1|D1
        A2|B2|D2
        A3|B3|D3
        A4|B4|D4"))
    end

    it "can remove a column indentified by its value" do
      described_class.new(options.merge(index_or_value: "C1")).run!
      expect(result).to eq(collapse("
        A1|B1|D1
        A2|B2|D2
        A3|B3|D3
        A4|B4|D4"))
    end
  end

end
