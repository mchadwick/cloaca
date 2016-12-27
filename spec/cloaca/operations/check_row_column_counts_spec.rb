require "spec_helper"

describe Cloaca::Operations::CheckRowColumnCount do

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

  context "given multiple rows with differing number of columns" do
    let(:input) { StringIO.new([
      ["A1", "B1", "C1", "D1"].join("|"),
      ["A2", "B2", "C2"].join("|"),
      ["A3", "B3", "C3", "D3"].join("|"),
      ["A4", "B4", "C4", "D4"].join("|"),
    ].join("\n")) }

    it "raises using an explicit column count" do
      subject = described_class.new(options.merge(column_delimiter: "|", count: 3))
      expect { subject.run! }.to raise_exception("invalid rows: 0, 2, 3")
    end

    it "raises using an implicit column count" do
      subject = described_class.new(options.merge(column_delimiter: "|"))
      expect { subject.run! }.to raise_exception("invalid rows: 1")
    end
  end

  context "given multiple rows with the same number of columns" do
    let(:input) { StringIO.new([
      ["A1", "B1", "C1", "D1"].join("|"),
      ["A2", "B2", "C2", "D2"].join("|"),
      ["A3", "B3", "C3", "D3"].join("|"),
      ["A4", "B4", "C4", "D4"].join("|"),
    ].join("\n")) }

    it "can validate the data using an explicit column count" do
      described_class.new(options.merge(column_delimiter: "|", count: 4)).run!
      expect(result).to eq(collapse("
        A1|B1|C1|D1
        A2|B2|C2|D2
        A3|B3|C3|D3
        A4|B4|C4|D4"))
    end

    it "can validate the data using an implicit column count" do
      described_class.new(options.merge(column_delimiter: "|")).run!
      expect(result).to eq(collapse("
        A1|B1|C1|D1
        A2|B2|C2|D2
        A3|B3|C3|D3
        A4|B4|C4|D4"))
    end

    it "raises invalid counts" do
      subject = described_class.new(options.merge(column_delimiter: "|", count: 3))
      expect { subject.run! }.to raise_exception("invalid rows: 0, 1, 2, 3")
    end
  end

end
