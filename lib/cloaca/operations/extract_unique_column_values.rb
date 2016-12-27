module Cloaca::Operations
  class ExtractUniqueColumnValues
    include Cloaca::Util::ColumnLookup

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
          @column_index = extract_index(line, @column_delimiter, @index_or_value)
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
