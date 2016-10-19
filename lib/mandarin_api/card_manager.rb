# frozen_string_literal: true
module MandarinApi
  # Manages cards assignment
  class CardManager
    def assign_card(user)
      params = { customer_info: { email: user.email, phone: user.phone } }
      MandarinApi::Wrapper.new(merchant_id: MandarinApi.config.merchant_id,
                               secret: MandarinApi.config.secret)
                          .request('/api/card-bindings', params)
    end
  end
end
