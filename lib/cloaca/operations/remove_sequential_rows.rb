module Cloaca::Operations
  class RemoveSequentialRows

    def initialize(
      ending_row_offset:,
      input:,
      output:,
      starting_row_offset:,
      **
    )
      @starting_row_offset = starting_row_offset
      @ending_row_offset = ending_row_offset
      @input = input
      @output = output
    end

    def run!
      @input.each_with_index do |line, index|
        if index < @starting_row_offset || index >= @ending_row_offset
          @output << line
        end
      end
    end

  end
end
