# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubypedia/version"


Gem::Specification.new do |s|
  s.name        = "rubypedia"
  s.version     = Rubypedia::VERSION
  s.authors     = ["gcimmino"]
  s.email       = ["giovanni.cimmino@gmail.com"]
  s.homepage    = "https://github.com/gcimmino/rubypedia"
  s.summary     = "Rubypedia wrapper for wikipedia API content"
  s.description = "Rubypedia extracts content from Wikipedia API"

  s.rubyforge_project = "rubypedia"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport'
  s.add_dependency 'httparty'
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency 'pry'
end
