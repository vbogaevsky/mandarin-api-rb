# frozen_string_literal: true
module MandarinApi
  # Processes callbacks from mandarinpay
  class Responder
    def initialize(data)
      @data = data
      @secret = MandarinApi.config.secret
      @process_status = if sign_is_valid
                          data[:status]
                        else
                          'failed'
                        end
    end

    def success
      @process_status == 'success'
    end

    def failure
      @process_status == 'failed'
    end

    private

    def sign_is_valid
      return false if !(@data.nil? || @data.empty?) && @data.class != Hash
      sign = @data.delete(:sign)
      Digest::SHA256.hexdigest(temp_string) == sign
    end

    def temp_string
      temp_string = ''
      @data.sort.to_h.keys.each do |key|
        temp_string += @data[key].to_s + '-'
      end
      temp_string + @secret
    end
  end
end
