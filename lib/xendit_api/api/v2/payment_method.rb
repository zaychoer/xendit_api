require 'xendit_api/api/base'
require 'xendit_api/model/v2/payment_method'

module XenditApi
  module Api
    module V2
      class PaymentMethod < XenditApi::Api::Base
        PATH = '/v2/payment_methods'.freeze

        def post(params, headers = {})
          response = client.post(PATH, params, headers)

          XenditApi::Model::PaymentMethod.new(response)
        end
      end
    end
  end
end
