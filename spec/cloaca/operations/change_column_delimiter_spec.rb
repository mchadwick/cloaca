require "spec_helper"

describe Cloaca::Operations::ChangeColumnDelimiter do

  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:result_rows) { result.split("\n") }

  def options(overrides = {})
    {
      input: input,
      old_column_delimiter: "|",
      output: output,
    }.merge(overrides)
  end

  context "given a single row" do
    let(:input) { StringIO.new([ %w(A B C D E).join("|") ].join("\n")) }

    it "can change the delimiter" do
      described_class.new(options.merge(new_column_delimiter: ",")).run!
      expect(result_rows.first).to eq("A,B,C,D,E")
    end

    it "can do nothing" do
      described_class.new(options.merge(new_column_delimiter: "|")).run!
      expect(result_rows.first).to eq("A|B|C|D|E")
    end
  end

end
