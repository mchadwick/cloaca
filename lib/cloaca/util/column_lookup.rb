module Cloaca::Util
  module ColumnLookup

    def extract_index(line, column_delimiter, index_or_value)
      header = line.strip.split(column_delimiter)

      # Preference given to header name instead of position
      column_index = header.index(index_or_value)

      # Fallback to position
      if !column_index && index_or_value.to_s.match(/\d+/)
        column_index = index_or_value.to_i
      end

      column_index
    end

  end
end
