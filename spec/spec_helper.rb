# frozen_string_literal: true
require 'webmock/rspec'
require 'faker'

Dir['./lib/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4.
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on a
    # real object. This is generally recommended, and will default to `true`
    # in RSpec 4.
    mocks.verify_partial_doubles = true
  end
end
