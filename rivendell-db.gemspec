# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rivendell/db/version'

Gem::Specification.new do |gem|
  gem.name          = "rivendell-db"
  gem.version       = Rivendell::DB::VERSION
  gem.authors       = ["Alban Peignier"]
  gem.email         = ["alban@tryphon.eu"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'dm-core'
  gem.add_runtime_dependency 'dm-mysql-adapter'
  gem.add_runtime_dependency 'dm-serializer'
  gem.add_runtime_dependency 'dm-types'
  gem.add_runtime_dependency 'dm-validations'

  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "dm-transactions"
end
