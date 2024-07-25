require 'xendit_api/api/base'
require 'xendit_api/model/credit_card_charge_option'

module XenditApi
  module Api
    class CreditCardChargeOption < XenditApi::Api::Base
      PATH = '/credit_card_charges/option'.freeze

      def get(params, headers = {})
        response = @client.get(PATH, params, headers)
        XenditApi::Model::CreditCardChargeOption.new(response)
      end
    end
  end
end
