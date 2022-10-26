# frozen_string_literal: true

require_relative "lib/extid/version"

Gem::Specification.new do |spec|
  spec.name = "extid"
  spec.version = ExtID::VERSION
  spec.authors = ["Jack Christensen"]
  spec.email = ["jack@jackchristensen.com"]

  spec.summary = "Convert integers to and from opaque external IDs"
  spec.description = "It can be valuable to internally use a serial integer as an ID without revealing that ID to the outside world. extid uses AES-128 to convert to and from an external ID that cannot feasibly be decoded without the secret key."
  spec.homepage = "https://github.com/jackc/ruby-extid"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
