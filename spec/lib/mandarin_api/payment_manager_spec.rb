# frozen_string_literal: true
RSpec.describe MandarinApi::PaymentManager do
  describe '#perform_payout' do
    let(:payment_manager) { MandarinApi::PaymentManager.new }
    let(:merchant_id) { 234 }
    let(:secret) { 'secret' }
    let(:params) do
      {
        order_id: 123_321, amount: 35_000,
        assigned_card_uuid: '0eb51e74-e704-4c36-b5cb-8f0227621518'
      }
    end
    let(:request_body) do
      {
        payment: { order_id: 123_321, action: 'payout', price: 35_000 },
        target: { card: '0eb51e74-e704-4c36-b5cb-8f0227621518' }
      }
    end
    it 'calls wrapper instance with args' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', request_body)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', request_body)
      payment_manager.perform_payout params
    end
  end
end
