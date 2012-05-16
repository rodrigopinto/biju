# -*- encoding: utf-8 -*-
require File.expand_path('../lib/biju/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rodrigo Pinto"]
  gem.email         = ["rodrigopqn@gmail.com"]
  gem.description   = %q{An easiest way to mount a GSM modem to send and to receive sms message}
  gem.summary       = %q{A ruby interface to use a GSM modem}
  gem.homepage      = "http://github.com/rodrigopinto/biju"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "biju"
  gem.require_paths = ["lib"]
  gem.version       = Biju::VERSION

  gem.add_development_dependency "minitest",    "3.0.0"

  gem.add_dependency "serialport",              "1.0.4"
end
