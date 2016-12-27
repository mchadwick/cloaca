module Cloaca::Operations
  class AddUuidColumn

    def initialize(
      column_delimiter:,
      column_header:,
      input:,
      output:,
      **
    )
      @column_delimiter = column_delimiter
      @column_header = column_header
      @input = input
      @output = output
    end

    def run!
      @input.each_with_index do |line, index|
        @output << (index == 0 && @column_header ? @column_header : SecureRandom.uuid)
        @output << @column_delimiter
        @output << line
      end
    end

  end
end
