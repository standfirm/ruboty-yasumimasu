
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/yasumimasu/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruboty-yasumimasu'
  spec.version       = Ruboty::Yasumimasu::VERSION
  spec.authors       = ['Fukaya Temma']
  spec.email         = ['ride.or.die.2215@gmail.com']

  spec.summary       = 'Add day off plans to Google calendar and spreadsheet from Ruboty'
  spec.description   = 'Add day off plans to Google calendar and spreadsheet from Ruboty'
  spec.homepage      = 'https://github.com/Pegasus204/ruboty-yasumimasu'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dotenv'
  spec.add_dependency 'google-api-client', '~> 0.8.0'
  spec.add_dependency 'google_drive'
  spec.add_dependency 'pry'
  spec.add_dependency 'ruboty'
  spec.add_development_dependency 'bundler', '>= 1.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop'
end
