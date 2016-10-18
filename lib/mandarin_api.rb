# frozen_string_literal: true
# Main class
#
# example:
# class Application
#   # internal
#
#   def assign_card(user)
#     MandarinApi.new(credentials).assign_card(user)
#   end
#
#   def pay(result)
#     MandarinApi.new(credentials).pay(result.client, result.amount)
#   end
#
#   def notify_reject_payment(result)
#     UserNotificator.notify(result.user, result.reason)
#   end
#
#   def transit(request)
#     MandarinApi.new(credentials)
#                .process_callback(request, ResponseHandler.new)
#   end
#
#   class ResponseHandler
#     def success(result)
#       ResultProcessor.succes(result)
#     end
#
#     def failure(result)
#       ResultProcessor.failure(result)
#     end
#   end
#
#   class ResultProcessor
#     def success(result)
#       pay(result)
#     end
#
#     def failure(result)
#       reject_payment(result)
#     end
#   end
# end

class MandarinApi
  extend Dry::Configurable

  def assign_card(user)
    MandarinApi::CardManager.new.assign_card user
  end

  def pay(client, amount)
    # call api
  end

  def process_callback(request_params, response_handler)
    response = MandarinApi::Responder.new.process(request_params)
    response_handler.success(response.data) if response.success
    response_handler.success(response.data) if response.success
  end
end
