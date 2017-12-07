# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github/version'

Gem::Specification.new do |spec|
  spec.name          = "cli-github"
  spec.version       = Cli::Github::VERSION
  spec.authors       = ["natmark"]
  spec.email         = ["natmark0918@gmail.com"]

  spec.summary       = %q{Useful GitHub command line tools}
  spec.description   = %q{cli-github makes it possible to create repo from console.}
  spec.homepage      = "https://github.com/natmark/cli-github/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "thor"
end
