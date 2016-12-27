module Cloaca::Operations
  class RemoveColumnQuotes
    include Cloaca::Util::ColumnLookup

    def initialize(
      column_delimiter:,
      index_or_value:,
      input:,
      output:,
      **
    )
      @index_or_value = index_or_value
      @column_delimiter = column_delimiter
      @input = input
      @output = output
    end

    def run!
      @input.each_with_index do |line, index|
        if index == 0
          @column_index = extract_index(line, @column_delimiter, @index_or_value)
        end

        if @column_index
          new_line = line.split(@column_delimiter)
          new_line[@column_index] = new_line[@column_index].gsub(/^\"(.*)\"$/, "\\1")
          @output << new_line.join(@column_delimiter)
        else
          @output << line
        end
      end
    end

  end
end
