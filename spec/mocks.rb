# frozen_string_literal: true
RSpec.shared_context 'mocks', shared_contex: :metadata do
  before :each do
    user_agent = "rest-client/#{Gem.loaded_specs['rest-client'].version} " \
      "(#{RbConfig::CONFIG['host_os']} #{RbConfig::CONFIG['host_cpu']}) " \
      "ruby/#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}"
    card_assign_body = JSON.generate(customerInfo: { email: 'ololo@gmail.com',
                                                     phone: '8-909-999-88-77' })
    payout_body =
      JSON.generate(
        payment: { orderId: 123_321, action: 'payout', price: 35_000 },
        target: { card: '0eb51e74-e704-4c36-b5cb-8f0227621518' }
      )
    header = {
      'Accept' => '*/*', 'Accept-Encoding' => 'gzip, deflate',
      'Content-Length' => '70', 'Content-Type' => 'application/json',
      'Host' => 'secure.mandarinpay.com',
      'User-Agent' => user_agent,
      'X-Auth' => 'x-auth'
    }
    stub_request(:post, 'https://secure.mandarinpay.com/api/card-bindings')
      .with(
        body: card_assign_body,
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
    stub_request(:post, 'https://secure.mandarinpay.com/api/transactions')
      .with(
        body: payout_body,
        headers: header
      )
      .to_return(
        status: 200,
        body:
          JSON.generate(
            id: '43913ddc000c4d3990fddbd3980c1725'
          ),
        headers: {}
      )
  end
end
