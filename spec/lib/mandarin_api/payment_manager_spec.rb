# frozen_string_literal: true
RSpec.describe MandarinApi::PaymentManager do
  let(:payment_manager) { MandarinApi::PaymentManager.new }
  let(:merchant_id) { 234 }
  let(:secret) { 'secret' }
  let(:params) do
    {
      order_id: 123_321, amount: 35_000,
      assigned_card_uuid: '0eb51e74-e704-4c36-b5cb-8f0227621518',
      custom_values: [{ name: 'a', value: 'A'}, { name: 'b', value: 'B' }]
    }
  end
  let(:normal_request_body) do
    {
      payment: { order_id: 123_321, action: action, price: 35_000 },
      target: { card: '0eb51e74-e704-4c36-b5cb-8f0227621518' },
      custom_values: [{ name: 'a', value: 'A'}, { name: 'b', value: 'B' }]
    }
  end
  let(:charge_request_body) do
    {
      payment: { order_id: 123_321, action: action, price: 35_000 },
      customer_info: { email: email, phone: phone },
      custom_values: [{ name: 'a', value: 'A'}, { name: 'b', value: 'B' }],
      urls: { callback: 'callback', return: 'return' }
    }
  end

  describe '#perform_charge' do
    let(:email) { Faker::Internet.free_email }
    let(:phone) { "+7#{Faker::Number.between(100_000_000, 999_999_999)}" }
    let(:action) { 'pay' }
    let(:params) do
      {
        order_id: 123_321, amount: 35_000, email: email, phone: phone,
        custom_values: [{ name: 'a', value: 'A'}, { name: 'b', value: 'B' }],
        urls: { callback: 'callback', return: 'return' }
      }
    end
    it 'calls wrapper instance with args' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', charge_request_body)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', charge_request_body)
      payment_manager.perform_charge params
    end
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

    let(:refund_request_body_w_price) do
      {
        payment: { order_id: 123_321, action: 'reversal', price: 1_000 },
        target: { transaction: '43913ddc000c4d3990fddbd3980c1725' }
      }
    end

    let(:params) do
      {
        order_id: 123_321, transaction_uuid: '43913ddc000c4d3990fddbd3980c1725'
      }
    end

    let(:params_w_price) do
      {
        order_id: 123_321, transaction_uuid: '43913ddc000c4d3990fddbd3980c1725',
        price: 1_000
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

    it 'add price to body if price was passed' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', refund_request_body)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/transactions', refund_request_body_w_price)
      payment_manager.perform_refund params_w_price
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
