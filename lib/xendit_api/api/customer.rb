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

      def get_by_reference_id(reference_id, headers = {})
        reference_id_path = "#{PATH}?reference_id=#{reference_id}"
        response = client.get(reference_id_path, nil, headers)
        # response is an array of customers
        XenditApi::Model::Customer.new(response['data'][0])
      end
    end
  end
end
