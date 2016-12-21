module Cloaca::Operations
  class AddIntegerIndexColumn

    def initialize(col_header:, col_sep:, row_offset:, input:, output:)
      @col_header = col_header
      @col_sep = col_sep
      @row_offset = col_header ? row_offset - 1 : row_offset
      @input = input
      @output = output
    end

    def run!
      @input.each_with_index do |line, index|
        @output << (index == 0 && @col_header ? @col_header : @row_offset + index)
        @output << @col_sep
        @output << line
      end
    end

  end
end
