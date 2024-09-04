require 'xendit_api/api/base'
require 'xendit_api/model/v2/simulate_payment'

module XenditApi
  module Api
    module V2
      class SimulatePayment < XenditApi::Api::Base
        PATH = '/v2/payment_methods'.freeze

        def post(params, id, headers = {})
          response = client.post("#{PATH}/#{id}/payments/simulate", params, headers)

          XenditApi::Model::V2::SimulatePayment.new(response)
        end
      end
    end
  end
end
