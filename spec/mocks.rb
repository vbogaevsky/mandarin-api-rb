# frozen_string_literal: true
RSpec.shared_context 'mocks', shared_contex: :metadata do
  before :each do
    user_agent = "rest-client/#{Gem.loaded_specs['rest-client'].version} " \
      "(#{RbConfig::CONFIG['host_os']} #{RbConfig::CONFIG['host_cpu']}) " \
      "ruby/#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}"
    body = JSON.generate(customerInfo: { email: 'ololo@gmail.com',
                                         phone: '8-909-999-88-77' })
    header = {
      'Accept' => '*/*', 'Accept-Encoding' => 'gzip, deflate',
      'Content-Length' => '70', 'Content-Type' => 'application/json',
      'Host' => 'secure.mandarinpay.com',
      'User-Agent' => user_agent,
      'X-Auth' => 'x-auth'
    }
    stub_request(:post, 'https://secure.mandarinpay.com/api/card-bindings')
      .with(
        body: body,
        headers: header
      )
      .to_return(
        status: 200,
        body:
          JSON.generate(
            id: '0eb51e74-e704-4c36-b5cb-8f0227621518',
            userWebLink: 'https://secure.mandarinpay.com/CardBindings/' \
              'New?id=0eb51e74-e704-4c36-b5cb-8f0227621518'
          ),
        headers: {}
      )
  end
end
