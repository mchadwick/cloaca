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

    private

    def assert_integer(key)
      if options[key] != options[key].to_i
        raise(Thor::MalformattedArgumentError.new("Expected integer value for '--#{key}'; got \"#{options[key]}\""))
      end
    end

    def parse_options
      {
        column_delimiter: options[:"col-delim"],
        column_header: options[:"col-header"],
        column_value: options[:"col-value"],
        index_delta: options[:"index-delta"],
        index_header: options[:"index-header"],
        index_seed: options[:"index-seed"],
        input: $stdin,
        output: $stdout,
      }
    end

  end
end
