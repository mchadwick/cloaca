require "spec_helper"

describe Cloaca::Operations::ValidateColumnFieldLength do

  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:result_rows) { result.split("\n") }

  def options(overrides = {})
    {
      column_delimiter: "|",
      column_index: 1,
      min_field_length: 1,
      max_field_length: 5,
      input: input,
      output: output,
    }.merge(overrides)
  end

  context "given rows with fewer columns than column_index" do
    let(:input) { StringIO.new([
      ["A2z", "B2z", "C2z"].join("|"),
      ["A1zz", "B1z", "C1", "D1z"].join("|"),      
    ].join("\n")) }

    it "raises using an explicit row contaning too few tokens" do
      subject = described_class.new(options.merge(column_delimiter: "|", column_index: 3, min_field_length: 4))
      expect { subject.run! }.to raise_exception("not enough tokens on line 0")
    end

    it "raises using an explicit row and column when a toen is too short" do
      subject = described_class.new(options.merge(column_delimiter: "|", column_index: 2, min_field_length: 3))
      expect { subject.run! }.to raise_exception("token in row 1, column 2 has inproper length, not >= 3")
    end

    it "raises using an explicit row and column when a token is too long" do
      subject = described_class.new(options.merge(column_delimiter: "|", column_index: 0, min_field_length: 2, max_field_length: 3))
      expect { subject.run! }.to raise_exception("token in row 1, column 0 has inproper length, not <= 3")
    end

    it "raises using an explicit exception when misconfigured with min and max field lengths" do
      expect { described_class.new(options.merge(
          column_delimiter: "|",
          column_index: 0,
          min_field_length: 3,
          max_field_length: 2))
      }.to raise_exception("configured with inproper min_field_length max_field_length")
    end
  end
end
