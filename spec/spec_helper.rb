$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

begin
  require "rubygems"
  spec = Gem::Specification.load("cloaca.gemspec")
  rspec = spec.dependencies.find { |d| d.name == "rspec" }
  gem "rspec", rspec.requirement.to_s
  require "rspec"
rescue LoadError
  abort "Run rake spec:deps to install development dependencies"
end

require "cloaca"
