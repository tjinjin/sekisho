
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sekisho/version"

Gem::Specification.new do |spec|
  spec.name          = "sekisho"
  spec.version       = Sekisho::VERSION
  spec.authors       = ["tjinjin"]
  spec.email         = ["tjinjinprogram@gmail.com"]

  spec.summary       = %q{Create milestone for github}
  spec.description   = %q{Create milestone for github}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = "sekisho"
  spec.require_paths = ["lib"]

  spec.add_dependency 'octokit'
  spec.add_dependency 'thor'
  spec.add_dependency 'term-ansicolor'
  spec.add_dependency 'slack-notifier'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
end
