# Barcodes is a RubyGem for creating and rendering common barcode symbologies.
#
# Author::    Aaron Wright  (mailto:acwrightdesign@gmail.com)
# Copyright:: Copyright (c) 2012 Infinite Token LLC
# License::  MIT License

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "barcodes/version"

Gem::Specification.new do |s|
  s.name        = "barcodes"
  s.version     = Barcodes::VERSION
  s.authors     = ["Aaron Wright"]
  s.email       = ["acwrightdesign@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Barcode creation using Ruby!}
  s.description = %q{Barcodes is a RubyGem for creating and rendering common barcode symbologies.}

  s.rubyforge_project = "barcodes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'prawn'
end
