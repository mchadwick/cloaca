module Cloaca::Operations
  class CheckRowColumnCount

    def initialize(
      column_delimiter:,
      count: nil,
      input:,
      output:,
      **
    )
      @column_delimiter = column_delimiter
      @count = count
      @input = input
      @output = output
    end

    def run!
      bad_indicies = []

      @input.each_with_index do |line, index|
        if index == 0 && !@count
          @count = line.split(@column_delimiter).count
        end

        if line.split(@column_delimiter).count != @count
          bad_indicies << index
        end

        @output.puts(line)
      end

      if bad_indicies.any?
        raise("invalid rows: #{bad_indicies.join(', ')}")
      end
    end

  end
end
