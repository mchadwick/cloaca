module Cloaca::Operations
  class AddNumericIndexColumn

    def initialize(
      column_delimiter:,
      index_delta:,
      index_header:,
      index_seed:,
      input:,
      output:
    )
      @column_delimiter = column_delimiter
      @index_delta = index_delta
      @index_header = index_header
      @index_seed = index_header ? index_seed - index_delta : index_seed
      @input = input
      @output = output
    end

    def run!
      use_big_decimal_math? ? run_with_big_decimals : run_with_integers
    end

    private

    def run_with_big_decimals
      cumulative_delta = BigDecimal.new(@index_seed)
      @input.each_with_index do |line, index|
        @output << (index == 0 && @index_header ? @index_header : cumulative_delta.to_digits)
        @output << @column_delimiter
        @output << line
        cumulative_delta = cumulative_delta + @index_delta
      end
    end

    def run_with_integers
      cumulative_delta = @index_seed.to_i
      @input.each_with_index do |line, index|
        @output << (index == 0 && @index_header ? @index_header : cumulative_delta.to_i)
        @output << @column_delimiter
        @output << line
        cumulative_delta = cumulative_delta + @index_delta
      end
    end

    def use_big_decimal_math?
      (@index_seed != @index_seed.to_i) || (@index_delta != @index_delta.to_i)
    end

  end
end
