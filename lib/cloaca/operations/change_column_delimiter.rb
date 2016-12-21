module Cloaca::Operations
  class ChangeColumnDelimiter

    def initialize(
      input:,
      new_column_delimiter:,
      old_column_delimiter:,
      output:,
      **
    )
      @old_column_delimiter = old_column_delimiter
      @new_column_delimiter = new_column_delimiter
      @col_sep_changed = (old_column_delimiter != new_column_delimiter)
      @input = input
      @output = output
    end

    def run!
      @input.each_with_index do |line, index|
        @output << (@col_sep_changed ? line.split(@old_column_delimiter).join(@new_column_delimiter) : line)
      end
    end

  end
end
