# frozen_string_literal: true
module MandarinApi
  # Pergorms payouts and payins
  class PaymentManager
    def perform_payout(params)
      MandarinApi::Wrapper.new(merchant_id: MandarinApi.config.merchant_id,
                               secret: MandarinApi.config.secret)
                          .request('/api/transactions', reques_body(params))
    end

    private

    def reques_body(params)
      {
        payment: {
          order_id: params[:order_id], action: 'payout', price: params[:amount]
        },
        target: {
          card: params[:assigned_card_uuid]
        }
      }
    end
  end
end
