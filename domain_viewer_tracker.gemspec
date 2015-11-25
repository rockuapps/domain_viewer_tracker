# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'domain_viewer_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = "domain_viewer_tracker"
  spec.version       = DomainViewerTracker::VERSION
  spec.authors       = ["ryonext"]
  spec.email         = ["ryonext.s@gmail.com"]
  spec.summary       = %q{Generate cookie with viewer id in same domain services.}
  spec.homepage      = "https://github.com/rockuapps/domain_viewer_tracker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "activerecord"
  spec.add_dependency "actionpack"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
end
