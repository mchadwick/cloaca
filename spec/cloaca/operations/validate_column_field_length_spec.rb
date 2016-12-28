require "spec_helper"

describe Cloaca::Operations::ValidateColumnFieldLength do

  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:column_index) { 1 }
  let(:field_length) { 1 }
  let(:result_rows) { result.split("\n") }

  def options(overrides = {})
    {
      column_delimiter: "|",
      column_index: column_index,
      field_length: field_length,
      input: input,
      output: output,
    }.merge(overrides)
  end

  context "given rows with fewer columns than column_index" do
    let(:input) { StringIO.new([
      ["A2z", "B2z", "C2z"].join("|"),
      ["A1z", "B1z", "C1", "D1z"].join("|"),      
    ].join("\n")) }

    it "raises using an explicit row contaning too few tokens" do
      subject = described_class.new(options.merge(column_delimiter: "|", column_index: 3, field_length: 4))
      expect { subject.run! }.to raise_exception("not enough tokens on line 0")
    end

    it "raises using an explicit row and column contaning a token too short" do
      subject = described_class.new(options.merge(column_delimiter: "|", column_index: 2, field_length: 3))
      expect { subject.run! }.to raise_exception("token in row 1, column 2 has inproper length, not equal to 3")
    end
  end
end
