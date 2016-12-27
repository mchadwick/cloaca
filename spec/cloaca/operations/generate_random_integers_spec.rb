require "spec_helper"

describe Cloaca::Operations::GenerateRandomIntegers do

  let(:output) { StringIO.new }
  let(:result) { output.string }
  let(:result_as_ints) { result.split("\n").map(&:to_i) }

  def options(overrides = {})
    {
      count: 0,
      delay_in_ms: 0,
      min: 0,
      max: 10,
      output: output,
    }.merge(overrides)
  end

  it "can generate no numbers" do
    described_class.new(options).run!
    expect(result).to eq("")
  end

  it "can generate one number" do
    described_class.new(options.merge(count: 1)).run!
    expect(result).to match(/(\d+\n){1}/)
  end

  it "can generate multiple numbers" do
    described_class.new(options.merge(count: 3)).run!
    expect(result).to match(/(\d+\n){3}/)
  end

  it "can delay the time between each number" do
    expect_any_instance_of(described_class).to receive(:sleep).with(0.001).exactly(2).times
    described_class.new(options.merge(count: 3, delay_in_ms: 1)).run!
  end

  it "only generates numbers greater than or equal to min" do
    min = rand(10)
    max = min + rand(10)
    described_class.new(options.merge(count: 100, min: min, max: max)).run!
    expect(result_as_ints.select { |n| n.to_i >= min }.count).to eq(100)
  end

  it "only generates numbers less than or equal max" do
    min = rand(10)
    max = min + rand(10)
    described_class.new(options.merge(count: 100, min: min, max: max)).run!
    expect(result_as_ints.select { |n| n <= max }.count).to eq(100)
  end

end
