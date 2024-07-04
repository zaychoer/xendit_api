require 'xendit_api/api/base'
require 'xendit_api/model/customer'

module XenditApi
  module Api
    class Customer < XenditApi::Api::Base
      PATH = '/customers'.freeze

      def create(params, headers = {})
        response = client.post(PATH, params, headers)
        XenditApi::Model::Customer.new(response)
      end
    end
  end
end
