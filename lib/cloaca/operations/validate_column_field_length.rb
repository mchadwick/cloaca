module Cloaca::Operations
  class ValidateColumnFieldLength

    def initialize(
      column_delimiter:,
      column_index: 0,
      field_length:,
      input:,
      output:,
      **
    )
      @column_delimiter = column_delimiter
      @column_index = column_index
      @field_length = field_length
      @input = input
      @output = output
    end

    def run!
      @input.each_with_index do |line, index|
        values = line.strip.split(@column_delimiter)
        raise("not enough tokens on line #{index}") if values.length <= @column_index
        raise("token in row #{index}, column #{@column_index} has inproper length, not equal to #{@field_length}") if values[@column_index].length != @field_length
        @output << line
      end # each
    end # run
  end # class
end  # module
