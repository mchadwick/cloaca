require "spec_helper"

describe Cloaca::Operations::AddIntegerIndexColumn do

  let(:input) { StringIO.new(%w(A B C D E).join("\n")) }
  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:result_rows) { result.split("\n") }

  it "can add an index column to an input stream" do
    described_class.new(col_header: nil, col_sep: "|", row_offset: 0, input: input, output: output).run!
    expect(result_rows).to eq(%w(0|A 1|B 2|C 3|D 4|E))
  end

  it "can include a custom column header on the index column" do
    described_class.new(col_header: "Row", col_sep: "|", row_offset: 0, input: input, output: output).run!
    expect(result_rows.first).to eq("Row|A")
  end

  it "can delimit rows values using a custom column separator" do
    described_class.new(col_header: nil, col_sep: ",", row_offset: 0, input: input, output: output).run!
    expect(result).to eq("0,A\n1,B\n2,C\n3,D\n4,E")
  end

  it "offsets the index using the initial offset for the first row when there is no header row" do
    described_class.new(col_header: nil, col_sep: "|", row_offset: 10, input: input, output: output).run!
    expect(result_rows.first).to eq("10|A")
  end

  it "offsets the index using the initial offset for the first row after the header when there is a header row" do
    described_class.new(col_header: "Row", col_sep: "|", row_offset: 10, input: input, output: output).run!
    expect(result_rows[1]).to eq("10|B")
  end

end
