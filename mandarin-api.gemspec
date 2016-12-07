# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name = 'mandarin-api'
  s.version = '0.0.10'
  s.authors = ['Vladimir Bogaevsky']
  s.email = 'gitvbogaevsky@gmail.com'
  s.licenses = ['MIT']
  s.summary = 'mandarinpay.com api wrapper for ruby'
  s.homepage = 'https://github.com/vbogaevsky/mandarin-api-rb'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README.md', 'plantuml/callbacks.puml']
  s.require_paths = ['lib']

  s.add_development_dependency('webmock', '~> 2.1')
  s.add_development_dependency('rspec', '~> 3.0')
  s.add_development_dependency('pry', '~> 0')
  s.add_development_dependency('pry-doc', '~> 0')
  s.add_development_dependency('rdoc', '>= 2.4.2', '< 5.0')
  s.add_development_dependency('rubocop', '~> 0')
  s.add_development_dependency('faker', '>= 1.6', '< 1.7')

  s.add_dependency 'rest-client', '>= 2.0', '< 3.0'

  s.required_ruby_version = '>= 2.2.0'
end
