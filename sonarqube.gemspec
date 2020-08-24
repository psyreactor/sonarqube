# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sonarqube/version'

Gem::Specification.new do |gem|
  gem.name          = 'sonarqube'
  gem.version       = Sonarqube::VERSION
  gem.authors       = ['Mariani Lucas']
  gem.email         = ['marianilucas@gmail.com']
  gem.description   = 'Ruby client for Sonarqube API'
  gem.summary       = 'A Ruby wrapper for the Sonarqube API'
  gem.homepage      = 'https://github.com/psyreactor/sonarqube'

  gem.files         = Dir['{lib}/**/*', 'LICENSE.txt', 'README.md', 'CHANGELOG.md']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.license       = 'BSD-2-Clause'

  gem.required_ruby_version = '>= 2.5'

  gem.add_runtime_dependency 'httparty', '~> 0.14', '>= 0.14.0'
  gem.add_runtime_dependency 'terminal-table', '~> 1.5', '>= 1.5.1'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
end
