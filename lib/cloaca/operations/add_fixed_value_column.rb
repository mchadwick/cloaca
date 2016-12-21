module Cloaca::Operations
  class AddFixedValueColumn

    def initialize(
      column_delimiter:,
      column_header:,
      column_value:,
      input:,
      output:,
      **
    )
      @column_delimiter = column_delimiter
      @column_header = column_header
      @column_value = column_value
      @input = input
      @output = output
    end

    def run!
      @input.each_with_index do |line, index|
        @output << (index == 0 && @column_header ? @column_header : @column_value)
        @output << @column_delimiter
        @output << line
      end
    end

  end
end
