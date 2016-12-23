
# TODO: could use a better name
# for removing consistent indentation from a multi-line string
def collapse(value)
  # ?= zero-width positive lookahead assertion
  indent = value.scan(/^[ \t]*(?=\S)/).min.size || 0
  value = value.gsub(/^[ \t]{#{indent}}/, '').gsub(/^\n/, '')
  value = "#{value}\n"
end
