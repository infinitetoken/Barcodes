# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "barcodes/version"

Gem::Specification.new do |s|
  s.name        = "barcodes"
  s.version     = Barcodes::VERSION
  s.authors     = ["Aaron Wright"]
  s.email       = ["acwrightdesign@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{PDF barcode creation using Ruby}
  s.description = %q{Barcodes can help you build and render barcodes as PDF}

  s.rubyforge_project = "barcodes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'prawn'
end
