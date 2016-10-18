module MandarinApi
  # Processes callbacks from mandarinpay
  class Responder
    def initialize(data)
      @process_status = data[:process_status]
      @data = data
    end

    def success
      yield data if @process_status.success?
    end

    def failure
      yield data if @process_status.failure?
    end
  end
end
