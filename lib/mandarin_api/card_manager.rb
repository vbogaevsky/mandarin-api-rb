# frozen_string_literal: true
module MandarinApi
  # Manages cards assignment
  class CardManager
    def assign_card(user, urls)
      params = { customer_info: { email: user.email, phone: phone(user) } }
      params[:urls] = urls unless urls.empty?
      MandarinApi::Wrapper.new(
        merchant_id: MandarinApi.config.merchant_id, secret: MandarinApi.config.secret,
        logger: MandarinApi.config.logger
      ).request('/api/card-bindings', params)
    end

    def one_side_assign_card(user, card)
      params = {
        customer_info: { email: user.email, phone: user.phone },
        target: { known_card_number: card }
      }
      MandarinApi::Wrapper.new(merchant_id: MandarinApi.config.merchant_id,
                               secret: MandarinApi.config.secret)
                          .request('/api/card-bindings', params)
    end

    private

    def phone(user)
      if user.phone.nil?
        '+70000000000'
      else
        '+' + user.phone.gsub(/[^\d]+/, '').gsub(/^8/, '7')
      end
    end
  end
end
