# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloaca/version'

Gem::Specification.new do |spec|
  spec.name          = "cloaca"
  spec.version       = Cloaca::VERSION
  spec.authors       = ["Matthew Chadwick"]
  spec.email         = ["matthew.chadwick@gmail.com"]

  spec.summary       = %q{Cloaca providers a library of transformations for CSV files and other row structured data.}
  spec.homepage      = "https://github.com/mchadwick/cloaca"
  spec.license       = "MIT"

  spec.add_dependency "thor", "~> 0.19"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
