require 'xendit_api/api/base'
require 'xendit_api/model/payment_request'

module XenditApi
  module Api
    class PaymentRequest < XenditApi::Api::Base
      PATH = '/payment_requests'.freeze

      def post(params, headers = {})
        response = client.post(PATH, params, headers)

        XenditApi::Model::PaymentRequest.new(response)
      end
    end
  end
end
