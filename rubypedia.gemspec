# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubypedia/version"


Gem::Specification.new do |s|
  s.name        = "rubypedia"
  s.version     = Rubypedia::VERSION
  s.authors     = ["gcimmino"]
  s.email       = ["giovanni.cimmino@mikamai.com"]
  s.homepage    = "https://github.com/gcimmino/rubypedia"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "rubypedia"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rake"
end
