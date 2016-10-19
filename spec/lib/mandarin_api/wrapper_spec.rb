# frozen_string_literal: true

RSpec.describe MandarinApi::Wrapper do
  include_context 'mocks'

  let(:wrapper) do
    MandarinApi::Wrapper
      .new(merchant_id: rand(1000), secret: SecureRandom.hex(5))
  end
  describe 'request' do
    let(:params) do
      {
        customer_info: {
          email: 'ololo@gmail.com', phone: '8-909-999-88-77'
        }
      }
    end
    let(:x_auth) { 'x-auth' }
    let(:mandarin_adress) { 'https://secure.mandarinpay.com/' }
    let(:expected) do
      {
        'id' => '0eb51e74-e704-4c36-b5cb-8f0227621518',
        'userWebLink' => 'https://secure.mandarinpay.com/CardBindings/New' \
          '?id=0eb51e74-e704-4c36-b5cb-8f0227621518'
      }
    end
    it 'sends request with passed action' do
      allow(wrapper).to receive(:generate_x_auth_header).and_return(x_auth)
      allow(MandarinApi).to \
        receive_message_chain(:config, :request_url).and_return(mandarin_adress)
      expect(wrapper.request('api/card-bindings', params)).to eq expected
    end
  end
  describe 'camelize' do
    let(:input) { 's_tri_ng' }
    let(:output) { 'sTriNg' }
    it 'input: underscored string, output: camelized string' do
      expect(wrapper.send(:camelize, input)).to eq output
    end
  end
  describe 'key_transform' do
    let(:input) do
      {
        big_key_one: {
          key_one: 1, key_two: 2, key_three: 3
        },
        big_key_two: {
          key_a: 'a', key_b: 'b'
        }
      }
    end
    let(:output) do
      {
        'bigKeyOne' => {
          'keyOne' => 1, 'keyTwo' => 2, 'keyThree' => 3
        },
        'bigKeyTwo' => {
          'keyA' => 'a', 'keyB' => 'b'
        }
      }
    end
    it 'input: multilevel hash with underscored keys-symbols, ' \
      'output: multilevel hash with camelized keys-strings' do
      expect(wrapper.send(:key_transform, input)).to eq output
    end
  end
end
