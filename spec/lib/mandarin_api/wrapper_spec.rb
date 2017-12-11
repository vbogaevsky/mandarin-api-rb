# frozen_string_literal: true
require 'logger'

RSpec.describe MandarinApi::Wrapper do
  include_context 'mocks'

  let(:wrapper) do
    MandarinApi::Wrapper.new(merchant_id: rand(1000), secret: SecureRandom.hex(5), logger: logger)
  end
  let(:logger) { nil }

  describe 'request' do
    let(:params) { { customer_info: { email: 'ololo@gmail.com', phone: '8-909-999-88-77' } } }
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

    describe 'logging' do
      before :example do
        `mkdir spec/temp`
      end

      after :example do
        `rm -rf spec/temp`
      end

      let(:actual) do
        File.readlines('spec/temp/logfile').last
      end

      let(:expected) do
        header = { 'content_type' => 'application/json', 'x_auth' => x_auth }
        url = URI.join(MandarinApi.config.request_url, 'api/card-bindings').to_s
        "Calling MandarinBank at: #{url}; body: #{params}, header: #{header}\n"
      end

      context 'Logger' do
        let(:logger) do
          Logger.new('spec/temp/logfile').tap do |logger|
            logger.formatter = proc { |_severity, _datetime, _progname, msg| "#{msg}\n" }
          end
        end
        it 'logs' do
          allow(wrapper).to receive(:generate_x_auth_header).and_return(x_auth)
          allow(MandarinApi).to \
            receive_message_chain(:config, :request_url).and_return(mandarin_adress)
          wrapper.request('api/card-bindings', params)
          expect(actual).to eq expected
        end
      end
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
        },
        a_r_r_a_y: [{ name: 'a_key', value: 'a' }]
      }
    end
    let(:output) do
      {
        'bigKeyOne' => {
          'keyOne' => 1, 'keyTwo' => 2, 'keyThree' => 3
        },
        'bigKeyTwo' => {
          'keyA' => 'a', 'keyB' => 'b'
        },
        'aRRAY' => [{ 'name' => 'a_key', 'value' => 'a' }]
      }
    end
    it 'input: multilevel hash with underscored keys-symbols, ' \
      'output: multilevel hash with camelized keys-strings' do
      expect(wrapper.send(:key_transform, input)).to eq output
    end
  end
end
