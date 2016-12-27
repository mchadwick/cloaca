require "spec_helper"

describe Cloaca::Operations::RemoveSequentialRows do

  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:result_rows) { result.split("\n") }

  def options(overrides = {})
    {
      input: input,
      output: output,
    }.merge(overrides)
  end

  context "given a single column" do
    let(:input) { StringIO.new(["A", "B", "C", "D", "E"].join("\n")) }

    it "can remove the first row" do
      described_class.new(options.merge(starting_row_offset: 0, ending_row_offset: 1)).run!
      expect(result_rows).to eq(%w(B C D E))
    end

    it "can remove the last row" do
      described_class.new(options.merge(starting_row_offset: 4, ending_row_offset: 5)).run!
      expect(result_rows).to eq(%w(A B C D))
    end

    it "can remove inner rows" do
      described_class.new(options.merge(starting_row_offset: 2, ending_row_offset: 4)).run!
      expect(result_rows).to eq(%w(A B E))
    end
  end

  context "given multiple columns" do
    let(:input) { StringIO.new([
      ["A1", "B1", "C1", "D1"].join("|"),
      ["A2", "B2", "C2", "D2"].join("|"),
      ["A3", "B3", "C3", "D3"].join("|"),
      ["A4", "B4", "C4", "D4"].join("|"),
    ].join("\n")) }

    it "removes the entire row" do
      described_class.new(options.merge(starting_row_offset: 1, ending_row_offset: 2)).run!
      # TODO: ensure output is consistent wrt new lines
      expect(result).to eq(collapse("
        A1|B1|C1|D1
        A3|B3|C3|D3
        A4|B4|C4|D4").strip)
    end
  end

end
