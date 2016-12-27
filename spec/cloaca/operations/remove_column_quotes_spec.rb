require "spec_helper"

describe Cloaca::Operations::RemoveColumnQuotes do

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

  context "given a single row with some quoted data" do

    let(:input) { StringIO.new([ ['"A"', "B\"\"B", "", "D"].join("|") ].join("\n")) }

    it "can remove quotes from a column identified by its position" do
      described_class.new(options.merge(index_or_value: 0)).run!
      expect(result_rows.first).to eq('A|B""B||D')
    end

    it "can remove quotes from a column indentified by its value" do
      described_class.new(options.merge(index_or_value: '"A"')).run!
      expect(result_rows.first).to eq('A|B""B||D')
    end

    it "does nothing if column has no quotes" do
      described_class.new(options.merge(index_or_value: "D")).run!
      expect(result_rows.first).to eq('"A"|B""B||D')
    end

    it "does nothing if column is not surrounded in quotes" do
      described_class.new(options.merge(index_or_value: 1)).run!
      expect(result_rows.first).to eq('"A"|B""B||D')
    end

    it "does nothing if column is empty" do
      described_class.new(options.merge(index_or_value: 2)).run!
      expect(result_rows.first).to eq('"A"|B""B||D')
    end
  end

end
