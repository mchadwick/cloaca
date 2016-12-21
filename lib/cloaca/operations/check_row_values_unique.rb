module Cloaca::Operations
  class CheckRowValuesUnique

    def initialize(
      case_sensitive: false,
      column_delimiter:,
      index: 0,
      input:,
      output:,
      **
    )
      @case_sensitive = case_sensitive
      @column_delimiter = column_delimiter
      @index = index
      @input = input
      @output = output
    end

    def run!
      duplicates = []
      @input.each_with_index do |line, index|
        if @index == index
          values = line.strip.split(@column_delimiter)
          if !@case_sensitive
            values = values.group_by { |x| x.downcase.to_s }
          else
            values = values.group_by(&:to_s)
          end
          duplicates = values.select { |k,v| v.count > 1 }.map { |k, v| v.first }.sort
          if duplicates.any?
            raise("duplicate value#{'s' if duplicates.count > 1} found: #{duplicates.join(', ')}")
          end
        end
        @output << line
      end
    end

  end
end
