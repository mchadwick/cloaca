require "spec_helper"

describe Cloaca::Operations::AddNumericIndexColumn do

  let(:input) { StringIO.new(%w(A B C D E).join("\n")) }
  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:result_rows) { result.split("\n") }

  def options(overrides = {})
    {
      column_delimiter: "|",
      index_delta: 1,
      index_header: nil,
      index_seed: 0,
      input: input,
      output: output,
    }.merge(overrides)
  end

  it "can add an index column to an input stream" do
    described_class.new(options).run!
    expect(result_rows).to eq(%w(0|A 1|B 2|C 3|D 4|E))
  end

  it "can increment index using a custom float delta" do
    described_class.new(options(index_delta: 10.1)).run!
    expect(result_rows).to eq(%w(0.0|A 10.1|B 20.2|C 30.3|D 40.4|E))
  end

  it "can increment index using a custom integer delta" do
    described_class.new(options(index_delta: 10)).run!
    expect(result_rows).to eq(%w(0|A 10|B 20|C 30|D 40|E))
  end

  it "can decrement index using a negative delta" do
    described_class.new(options(index_delta: -10)).run!
    expect(result_rows).to eq(%w(0|A -10|B -20|C -30|D -40|E))
  end

  it "can include a custom column header on the index column" do
    described_class.new(options(index_header: "Row")).run!
    expect(result_rows.first).to eq("Row|A")
  end

  it "can delimit rows values using a custom column separator" do
    described_class.new(options(column_delimiter: ",")).run!
    expect(result).to eq("0,A\n1,B\n2,C\n3,D\n4,E")
  end

  it "offsets the index using the initial offset for the first row when there is no header row" do
    described_class.new(options(index_seed: 10)).run!
    expect(result_rows.first).to eq("10|A")
  end

  it "offsets the index using the initial offset for the first row after the header when there is a header row" do
    described_class.new(options(index_header: "Row", index_seed: 10)).run!
    expect(result_rows[1]).to eq("10|B")
  end

end
