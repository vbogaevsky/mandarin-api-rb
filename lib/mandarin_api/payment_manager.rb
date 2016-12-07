# frozen_string_literal: true
module MandarinApi
  # Pergorms payouts and payins
  class PaymentManager
    def perform_charge(params)
      perform(params, 'pay', :charge_request_body)
    end

    def perform_payout(params)
      perform(params, 'payout', :normal_request_body)
    end

    def perform_payment(params)
      perform(params, 'pay', :normal_request_body)
    end

    def perform_refund(params)
      perform(params, 'reversal', :refund_request_body)
    end

    def perform_rebill(params)
      perform(params, 'pay', :rebill_request_body)
    end

    private

    def perform(params, action, body)
      MandarinApi::Wrapper.new(
        merchant_id: MandarinApi.config.merchant_id,
        secret: MandarinApi.config.secret
      ).request('/api/transactions', send(body, params, action))
    end

    def normal_request_body(params, action)
      {
        payment: payment(params, action),
        target: { card: params[:assigned_card_uuid] }
      }
    end

    def charge_request_body(params, action)
      {
        payment: payment(params, action),
        customer_info: { email: params[:email], phone: params[:phone] },
        custom_values: []
      }
    end

    def refund_request_body(params, action)
      {
        payment: { order_id: params[:order_id], action: action },
        target: { transaction: params[:transaction_uuid] }
      }
    end

    def rebill_request_body(params, action)
      {
        payment: payment(params, action),
        target: { rebill: params[:transaction_uuid] }
      }
    end

    def payment(params, action)
      { order_id: params[:order_id], action: action, price: params[:amount] }
    end
  end
end
