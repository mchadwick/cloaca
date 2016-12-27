require "bigdecimal"
require "bigdecimal/util"
begin
  require "SecureRandom"
  rescue LoadError
    puts "Could not load 'SecureRandom'"
  end
require "thor"

require "cloaca/version"
require "cloaca/cli"
require "cloaca/util/column_lookup"
require "cloaca/operations/add_fixed_value_column"
require "cloaca/operations/add_numeric_index_column"
require "cloaca/operations/add_uuid_column"
require "cloaca/operations/change_column_delimiter"
require "cloaca/operations/check_row_column_counts"
require "cloaca/operations/check_row_values_unique"
require "cloaca/operations/extract_unique_column_values"
require "cloaca/operations/generate_random_integers"
require "cloaca/operations/remove_column"
require "cloaca/operations/remove_column_quotes"
require "cloaca/operations/remove_sequential_rows"
