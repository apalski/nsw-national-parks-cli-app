# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'NSWParks/version'

Gem::Specification.new do |spec|
  spec.name          = "NSWParks"
  spec.version       = NSWParks::VERSION
  spec.authors       = ["Annette Drapalski"]
  spec.email         = ["annette.drapalski@gmail.com"]
  spec.summary       = %q{Supply information on NSW National Parks}
  spec.description   = %q{Access to information on National Parks in the Australian State of New South Wales}
  spec.homepage      = "https://github.com/apalski/nsw-national-parks-cli-app"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($\)
  spec.executables = ["NSWParks"] 
  spec.require_paths = ["lib", "lib/NSWParks"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", "~> 0"
end
