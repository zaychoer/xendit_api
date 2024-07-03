require 'xendit_api/model/base'

module XenditApi
  module Model
    module V2
      class PaymentMethod < XenditApi::Model::Base
        attr_accessor :id,
                      :type,
                      :country,
                      :business_id,
                      :customer_id,
                      :reference_id,
                      :reusability,
                      :status,
                      :actions,
                      :description,
                      :created,
                      :updated,
                      :metadata,
                      :billing_information,
                      :failure_code,
                      :ewallet,
                      :direct_bank_transfer,
                      :direct_debit,
                      :card,
                      :over_the_counter,
                      :qr_code,
                      :virtual_account
      end
    end
  end
end
