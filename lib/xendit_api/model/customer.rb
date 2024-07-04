require 'xendit_api/model/base'

module XenditApi
  module Model
    class Customer < XenditApi::Model::Base
      attr_accessor :id,
                    :type,
                    :date_of_registration,
                    :email,
                    :mobile_number,
                    :phone_number,
                    :created,
                    :updated,
                    :description,
                    :hashed_phone_number,
                    :domicile_of_registration,
                    :kyc_documents,
                    :reference_id,
                    :metadata,
                    :individual_details,
                    :business_details,
                    :addresses,
                    :identity_accounts
    end
  end
end
