require 'xendit_api/model/base'

module XenditApi
  module Model
    class PaymentRequest < XenditApi::Model::Base
      attr_accessor :id,
                    :country,
                    :amount,
                    :currency,
                    :business_id,
                    :reference_id,
                    :payment_method,
                    :description,
                    :metadata,
                    :customer_id,
                    :capture_method,
                    :initiator,
                    :card_verification_results,
                    :created,
                    :updated,
                    :status,
                    :actions,
                    :failure_code,
                    :channel_properties,
                    :shipping_information,
                    :items
    end
  end
end
