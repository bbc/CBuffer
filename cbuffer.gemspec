# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cbuffer/version"

Gem::Specification.new do |s|
  s.name        = "cbuffer"
  s.version     = CBuffer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Duncan Robertson"]
  s.email       = ["duncan.robertson@bbc.co.uk"]
  s.homepage    = "https://github.com/bbcrd/CBuffer"
  s.summary     = %q{A simple implementation of a circular buffer}
  s.description = %q{A circular buffer, cyclic buffer or ring buffer is a data structure that uses a single, fixed-size buffer as if it were connected end-to-end. This structure lends itself easily to buffering data streams. This library impliments such a buffer.}
  
  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')

  s.add_development_dependency "rake"
  s.add_development_dependency("bundler", ">= 1.0.0")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
