lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "time_spanner/version"

Gem::Specification.new do |spec|
  spec.name = "time_spanner"
  spec.version = TimeSpanner::VERSION
  spec.authors = ["Andreas Busold"]
  spec.email = ["andreas.busold@gmail.com"]
  spec.description = "Returns a time span, split into desired units, given two timestamps."
  spec.summary = "Returns a time span, split into desired units, given two timestamps."
  spec.homepage = "https://github.com/shlub/time_spanner/"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
