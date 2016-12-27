module Cloaca::Operations
  class ExtractUniqueColumnValues

    def initialize(
      column_delimiter:,
      index_or_value:,
      input:,
      output:,
      row_offset: 0,
      **
    )
      @index_or_value = index_or_value
      @row_offset = row_offset
      @column_delimiter = column_delimiter
      @input = input
      @output = output
    end

    def run!
      unique_values = Set.new

      @input.each_with_index do |line, index|
        if index == 0
          # TODO: extract in order to maintain consistency in lookup implementation (see remove-column operation)
          header = line.strip.split(@column_delimiter)

          # Preference given to header name instead of position
          @column_index = header.index(@index_or_value)

          # Fallback to position
          if !@column_index && @index_or_value && @index_or_value.to_f == @index_or_value.to_i
            @column_index = @index_or_value.to_i
          end
        end

        if @column_index
          if index < @row_offset
            next
          end

          value = line.split(@column_delimiter)[@column_index]

          if !unique_values.include?(value)
            unique_values.add(value)
            @output.puts(value)
          end
        end
      end
    end

  end
end
