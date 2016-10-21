# frozen_string_literal: true
RSpec.describe MandarinApi::Responder do
  let(:data) { unsign_data.merge(sign: sign) }
  let(:responder) { MandarinApi::Responder.new(data) }
  describe '#success' do
    context 'success' do
      let(:unsign_data) do
        {
          card_holder: 'VASILY PUPKIN',
          card_number: '123456XXXXXX7890',
          card_expiration_year: 18,
          card_expiration_month: 9,
          status: 'success'
        }
      end
      let(:sign) do
        Digest::SHA256.hexdigest(
          '9-18-VASILY PUPKIN-123456XXXXXX7890-success-secret'
        )
      end
      it 'returns true' do
        allow(MandarinApi).to \
          receive_message_chain(:config, :secret).and_return('secret')
        expect(responder.success).to eq true
      end
    end
    context 'failure' do
      let(:unsign_data) do
        {
          card_holder: 'VASILY PUPKIN',
          card_number: '123456XXXXXX7890',
          card_expiration_year: 18,
          card_expiration_month: 9,
          status: 'failed'
        }
      end
      let(:sign) do
        Digest::SHA256.hexdigest(
          '9-18-VASILY PUPKIN-123456XXXXXX7890-failed-secret'
        )
      end
      it 'returns true' do
        allow(MandarinApi).to \
          receive_message_chain(:config, :secret).and_return('secret')
        expect(responder.success).to eq false
      end
    end
  end
  describe '#failure' do
    context 'success' do
      let(:unsign_data) do
        {
          card_holder: 'VASILY PUPKIN',
          card_number: '123456XXXXXX7890',
          card_expiration_year: 18,
          card_expiration_month: 9,
          status: 'success'
        }
      end
      let(:sign) do
        Digest::SHA256.hexdigest(
          '9-18-VASILY PUPKIN-123456XXXXXX7890-success-secret'
        )
      end
      it 'returns true' do
        allow(MandarinApi).to \
          receive_message_chain(:config, :secret).and_return('secret')
        expect(responder.failure).to eq false
      end
    end
    context 'failure' do
      let(:unsign_data) do
        {
          card_holder: 'VASILY PUPKIN',
          card_number: '123456XXXXXX7890',
          card_expiration_year: 18,
          card_expiration_month: 9,
          status: 'failed'
        }
      end
      let(:sign) do
        Digest::SHA256.hexdigest(
          '9-18-VASILY PUPKIN-123456XXXXXX7890-failed-secret'
        )
      end
      it 'returns true' do
        allow(MandarinApi).to \
          receive_message_chain(:config, :secret).and_return('secret')
        expect(responder.failure).to eq true
      end
    end
  end
end
