# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "nagios/api/version"

Gem::Specification.new do |s|
  s.name        = "nagios-api-client"
  s.version     = Nagios::API::VERSION
  s.author      = "Philippe Green, Greenview Data, Inc."
  s.email       = ["development@greenviewdata.com"]
  s.homepage    = "https://github.com/gdi/ruby-nagios-api-client"
  s.license     = "MIT"
  s.summary     = %q{Interface to interact with the nagios-api server}
  s.description = %q{Interact with the nagios-api (REST interface to Nagios) server found at github.com/xb95/nagios-api}
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency "curb-fu"
  
  s.add_development_dependency "rspec"
end
