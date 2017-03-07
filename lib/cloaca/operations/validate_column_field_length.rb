module Cloaca::Operations
  class ValidateColumnFieldLength

    def initialize(
      column_delimiter:,
      column_index: 0,
      min_field_length:,
      max_field_length:,
      input:,
      output:,
      **
    )
      @column_delimiter = column_delimiter
      @column_index = column_index
      @min_field_length = min_field_length
      @max_field_length = max_field_length || @min_field_length
      @input = input
      @output = output
      raise("configured with inproper min_field_length max_field_length") if @min_field_length > @max_field_length
    end

    def run!
      @input.each_with_index do |line, index|
        values = line.strip.split(@column_delimiter)
        raise("not enough tokens on line #{index}") if values.length <= @column_index
        raise("token in row #{index}, column #{@column_index} has inproper length, not >= #{@min_field_length}") if values[@column_index].length < @min_field_length
        raise("token in row #{index}, column #{@column_index} has inproper length, not <= #{@max_field_length}") if values[@column_index].length > @max_field_length
        @output << line
      end # each
    end # run
  end # class
end  # module
