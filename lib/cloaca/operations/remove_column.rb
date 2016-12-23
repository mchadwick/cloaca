module Cloaca::Operations
  class RemoveColumn

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
          header = line.strip.split(@column_delimiter)

          # Preference given to header name instead of position
          @column_index = header.index(@index_or_value)

          # Fallback to position
          if !@column_index && @index_or_value == @index_or_value.to_i
            @column_index = @index_or_value.to_i
          end
        end

        if @column_index
          # TODO: need to spec other operations with multi-line input and ensure output is consistent
          # close proceeding line; last line does not have a newline
          # if index > 0
          #   @output << "\n"
          # end

          new_line = line.strip.split(@column_delimiter)
          new_line.delete_at(@column_index)
          @output << new_line.join(@column_delimiter)
          @output << "\n"
        else
          # Only catches absence of named header, numeric values for non-existing columns will always populate @column_index
          @output << line
        end
      end
    end

  end
end
