# frozen_string_literal: true
RSpec.describe MandarinApi::PaymentManager do
  let(:payment_manager) { MandarinApi::PaymentManager.new }
  let(:merchant_id) { 234 }
  let(:secret) { 'secret' }
  let(:params) do
    {
      order_id: 123_321, amount: 35_000,
      assigned_card_uuid: '0eb51e74-e704-4c36-b5cb-8f0227621518'
    }
  end
  let(:normal_request_body) do
    {
      payment: { order_id: 123_321, action: action, price: 35_000 },
      target: { card: '0eb51e74-e704-4c36-b5cb-8f0227621518' }
    }
  end
  describe '#perform_payout' do
    let(:action) { 'payout' }
    it 'calls wrapper instance with args' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', normal_request_body)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', normal_request_body)
      payment_manager.perform_payout params
    end
  end

  describe '#perform_payment' do
    let(:action) { 'pay' }
    it 'calls wrapper instance with args' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', normal_request_body)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', normal_request_body)
      payment_manager.perform_payment params
    end
  end

  describe '#perform_refund' do
    let(:refund_request_body) do
      {
        payment: { order_id: 123_321, action: 'reversal' },
        target: { transaction: '43913ddc000c4d3990fddbd3980c1725' }
      }
    end
    let(:params) do
      {
        order_id: 123_321, transaction_uuid: '43913ddc000c4d3990fddbd3980c1725'
      }
    end
    it 'calls wrapper instance with args' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', refund_request_body)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', refund_request_body)
      payment_manager.perform_refund params
    end
  end

  describe '#perform_rebill' do
    let(:rebill_request_body) do
      {
        payment: { order_id: 123_321, action: 'pay', price: 35_000 },
        target: { rebill: '43913ddc000c4d3990fddbd3980c1725' }
      }
    end
    let(:params) do
      {
        order_id: 123_321, amount: 35_000,
        transaction_uuid: '43913ddc000c4d3990fddbd3980c1725'
      }
    end
    it 'calls wrapper instance with args' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', rebill_request_body)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', rebill_request_body)
      payment_manager.perform_rebill params
    end
  end
end
