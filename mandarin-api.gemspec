# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name = 'mandarin-api'
  s.version = '0.0.0'
  s.authors = ['Vladimir Bogaevsky', 'Boris Kraportov']
  s.licenses = ['MIT']
  s.summary = 'mandarinpay.com api wrapper for ruby'
  s.homepage = 'https://github.com/vbogaevsky/mandarin-api-rb'
  s.extra_rdoc_files = ['README.md']

  s.add_development_dependency('webmock', '~> 2.1')
  s.add_development_dependency('rspec', '~> 3.0')
  s.add_development_dependency('pry', '~> 0')
  s.add_development_dependency('pry-doc', '~> 0')
  s.add_development_dependency('rdoc', '>= 2.4.2', '< 5.0')
  s.add_development_dependency('rubocop', '~> 0')

  s.add_dependency 'rest-client', '>= 2.0', '< 3.0'
  s.add_dependency 'dry-configurable', '>= 0.1.0', '< 1.0'

  s.required_ruby_version = '>= 2.2.0'
end
