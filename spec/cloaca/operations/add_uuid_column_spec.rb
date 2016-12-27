require "spec_helper"

describe Cloaca::Operations::AddUuidColumn do

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

  def uuid(x)
    "#{x*8}-#{x*4}-#{x*4}-#{x*4}-#{x*12}"
  end

  before do
    uuid_values = %w(a b c d e).map { |x| uuid(x) }
    allow(SecureRandom).to receive(:uuid).and_return(*uuid_values)
  end

  it "can add an value column to an input stream" do
    described_class.new(options).run!
    expect(result_rows).to eq(["#{uuid('a')}|A", "#{uuid('b')}|B", "#{uuid('c')}|C", "#{uuid('d')}|D", "#{uuid('e')}|E"])
  end

  it "can include a custom column header on the value column" do
    described_class.new(options.merge(column_header: "Row")).run!
    expect(result_rows).to eq(["Row|A", "#{uuid('a')}|B", "#{uuid('b')}|C", "#{uuid('c')}|D", "#{uuid('d')}|E"])
  end

end
