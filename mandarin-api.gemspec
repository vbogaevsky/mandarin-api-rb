# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'mandarin-api'
  s.version = '1.0.1'
  s.authors = ['Vladimir Bogaevsky']
  s.email = 'gitvbogaevsky@gmail.com'
  s.licenses = ['MIT']
  s.summary = 'mandarinpay.com api wrapper for ruby'
  s.homepage = 'https://github.com/vbogaevsky/mandarin-api-rb'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README.md', 'plantuml/callbacks.puml']
  s.require_paths = ['lib']

  s.add_development_dependency('rspec',   '~> 3.7', '>= 3.7.0')
  s.add_development_dependency('webmock', '~> 3.1', '>= 3.1.1')

  s.add_dependency('curb', '~> 0.9.4')

  s.required_ruby_version = '>= 2.4.2'
end
