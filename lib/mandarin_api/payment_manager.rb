# frozen_string_literal: true
module MandarinApi
  # Pergorms payouts and payins
  class PaymentManager
    def perform_payout(params)
      perform(params, 'payout')
    end

    def perform_payment(params)
      perform(params, 'pay')
    end

    private

    def perform(params, action)
      MandarinApi::Wrapper.new(
        merchant_id: MandarinApi.config.merchant_id,
        secret: MandarinApi.config.secret
      ).request('/api/transactions', request_body(params, action))
    end

    def request_body(params, action)
      {
        payment: {
          order_id: params[:order_id], action: action, price: params[:amount]
        },
        target: {
          card: params[:assigned_card_uuid]
        }
      }
    end
  end
end
