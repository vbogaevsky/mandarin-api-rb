# frozen_string_literal: true
RSpec.describe MandarinApi::Wrapper do
  describe 'request' do
    let(:wrapper) do
      MandarinApi::Wrapper
        .new(merchant_id: rand(1000), secret: SecureRandom.hex(5))
    end
    let(:params) do
      {
        customer_info: {
          email: 'ololo@gmail.com', phone: '8-909-999-88-77'
        }
      }
    end
    let(:mandarin_adress) { 'https://secure.mandarinpay.com/' }
    let(:expected) do
      {
        id: '0eb51e74-e704-4c36-b5cb-8f0227621518',
        userWebLink: 'https://secure.mandarinpay.com/CardBindings/New' /
          '?id=0eb51e74-e704-4c36-b5cb-8f0227621518'
      }
    end
    it 'sends request with passed action' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :request_url).and_return(mandarin_adress)
      expect(wrapper.request('api/card-bindings', params)).to eq expected
    end
  end
end
