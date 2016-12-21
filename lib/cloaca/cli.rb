module Cloaca
  class CLI < Thor

    package_name "Cloaca"

    desc "add-integer-index-column", "adds a index column to a stream of data"
    method_option :"col-sep", type: :string, default: "|", banner: "column delimiter"
    method_option :header, type: :string
    method_option :index, type: :numeric
    method_option :"row-offset", type: :numeric, default: 0, banner: "initial index offset"

    def add_integer_index_column
      fail "row-offset must be an integer" if options[:"row-offset"] != options[:"row-offset"].to_i
      Operations::AddIntegerIndexColumn.new(parse_options).run!
    end

    private

    def parse_options
      {
        col_header: options[:header],
        col_sep: options[:"col-sep"],
        row_offset: options[:"row-offset"],
        input: $stdin,
        output: $stdout,
      }
    end

  end
end
