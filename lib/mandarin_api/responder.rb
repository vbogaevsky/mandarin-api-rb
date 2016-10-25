# frozen_string_literal: true
module MandarinApi
  # Processes callbacks from mandarinpay
  class Responder
    attr_reader :data
    def initialize(data)
      @data = data
      @secret = MandarinApi.config.secret
      if sign_is_valid
        @process_status = @data[:status]
      else
        @process_status = 'failed'
        @data = { sign: 'Wrong signature!' }
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
        temp_string
      end
      temp_string + @secret
    end
  end
end
