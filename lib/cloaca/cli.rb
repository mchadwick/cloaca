module Cloaca
  class CLI < Thor

    package_name "Cloaca"

    desc "add-integer-index-column", "adds a index column to a stream of data"
    method_option :"col-delim", type: :string, default: "|", banner: "column delimiter"
    method_option :"index-header", type: :string, banner: "index header value or omit if no header row"
    method_option :"index-delta", type: :numeric, default: 1, banner: "delta between consecutive index values"
    method_option :"index-seed", type: :numeric, default: 0, banner: "initial index value"

    def add_integer_index_column
      assert_integer(:"index-delta")
      assert_integer(:"index-seed")
      Operations::AddNumericIndexColumn.new(parse_options).run!
    end

    desc "add-numeric-index-column", "adds a index column to a stream of data"
    method_option :"col-delim", type: :string, default: "|", banner: "column delimiter"
    method_option :"index-header", type: :string, banner: "index header value or omit if no header row"
    method_option :"index-delta", type: :numeric, default: 1, banner: "delta between consecutive index values"
    method_option :"index-seed", type: :numeric, default: 0, banner: "initial index value"

    def add_numeric_index_column
      Operations::AddNumericIndexColumn.new(parse_options).run!
    end

    desc "add-fixed-value-column", "adds a fixed value column to a stream of data"
    method_option :"col-delim", type: :string, default: "|", banner: "column delimiter"
    method_option :"col-header", type: :string, banner: "header value or omit if no header row"
    method_option :"col-value", type: :string, required: true, banner: "column cell value"

    def add_fixed_value_column
      Operations::AddFixedValueColumn.new(parse_options).run!
    end

    desc "change-col-delimiter", "change the column delimiter for a stream of data"
    method_option :"old-col-delim", type: :string, default: "|", banner: "column delimiter"
    method_option :"new-col-delim", type: :string, required: true, banner: "column delimiter"

    def change_col_delimiter
      Operations::ChangeColumnDelimiter.new(parse_options).run!
    end


    desc "check-headers-unique", "checks that each column has a unique header value"
    method_option :"col-delim", type: :string, default: "|", banner: "column delimiter"
    method_option :"case-sensitive", type: :boolean, default: false, banner: "perform case sensitive check"

    def check_headers_unique
      Operations::CheckRowValuesUnique.new(parse_options).run!
    end

    desc "extract-unique-col-values", "extract unique vlaues for a column, one per line"
    method_option :"col-delim", type: :string, default: "|", banner: "column delimiter"
    method_option :"index-or-value", type: :string, required: true, banner: "column index or header"
    method_option :"row-offset", type: :numeric, default: 0, banner: "initial offset (use 1 to skip a single row header)"

    def extract_unique_col_values
      assert_integer(:"row-offset")

      Operations::ExtractUniqueColumnValues.new(parse_options).run!
    end

    desc "generate-int N", "generates N random integers, one per line"
    method_option :count, type: :numeric, default: 1
    method_option :min, type: :numeric, default: 0
    method_option :max, type: :numeric, default: 100000
    method_option :delay_in_ms, type: :numeric, default: 1000, banner: "N milliseconds"

    def generate_int
      assert_integer(:min)
      assert_integer(:max)
      assert_less_than(:min, :max)

      Operations::GenerateRandomIntegers.new(parse_options).run!
    end

    desc "remove-column (index or value)", "removes the column"
    method_option :"col-delim", type: :string, default: "|", banner: "column delimiter"
    method_option :"index-or-value", type: :string, required: true, banner: "column index or header"

    def remove_column
      Operations::RemoveColumn.new(parse_options).run!
    end

    private

    def assert_integer(key)
      if options[key] != options[key].to_i
        raise(Thor::MalformattedArgumentError.new("Expected integer value for '--#{key}'; got \"#{options[key]}\""))
      end
    end

    def assert_less_than(a, b)
      if options[a] > options[b]
        raise(Thor::MalformattedArgumentError.new("Expected #{a} to be less than or equal to #{b} ; got \"#{options[a]}\" which is not <= \"#{options[b]}\""))
      end
    end

    def parse_options
      {
        case_sensitive: options[:"case-sensitive"],
        column_delimiter: options[:"col-delim"],
        column_header: options[:"col-header"],
        column_value: options[:"col-value"],
        count: options[:count],
        delay_in_ms: options[:delay_in_ms],
        index_delta: options[:"index-delta"],
        index_header: options[:"index-header"],
        index_or_value: options[:"index-or-value"],
        index_seed: options[:"index-seed"],
        input: $stdin,
        max: options[:max],
        min: options[:min],
        new_column_delimiter: options[:"new-col-delim"],
        old_column_delimiter: options[:"old-col-delim"],
        row_offset: options[:"row-offset"],
        output: $stdout,
      }
    end

  end
end
