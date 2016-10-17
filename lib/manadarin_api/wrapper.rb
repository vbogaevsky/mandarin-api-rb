# frozen_string_literal: true
# Wraps request sending
class Wrapper
  def initialize(merchant_id:, secret:)
    @merchant_id = merchant_id
    @secret = secret
  end

  def request(endpoint, params)
    RestClient.post(URI.join(MandarinApi.config.request_url, endpoint),
                    params, header)
  end

  private

  def header
    {
      'Content-Type' => 'application/json',
      'X-Auth' => generate_x_auth_header(@merchant_id, @secret)
    }
  end

  def generate_x_auth_header(merchant_id, secret)
    request_id = "#{Time.now}_#{Time.now.to_i}_#{rand}"
    hash = Digest::SHA256.new "#{merchant_id}-#{request_id}-#{secret}"
    "#{merchant_id}-#{hash}-#{request_id}"
  end
end
