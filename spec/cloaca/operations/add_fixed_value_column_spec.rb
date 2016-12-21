require "spec_helper"

describe Cloaca::Operations::AddFixedValueColumn do

  let(:input) { StringIO.new(%w(A B C D E).join("\n")) }
  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:result_rows) { result.split("\n") }

  def options(overrides = {})
    {
      column_delimiter: "|",
      column_header: nil,
      input: input,
      output: output,
    }.merge(overrides)
  end

  it "can add an value column to an input stream" do
    described_class.new(options.merge(column_value: "1")).run!
    expect(result_rows).to eq(%w(1|A 1|B 1|C 1|D 1|E))
  end

  it "can include a custom column header on the value column" do
    described_class.new(options.merge(column_header: "Row", column_value: "X")).run!
    expect(result_rows).to eq(%w(Row|A X|B X|C X|D X|E))
  end

end
