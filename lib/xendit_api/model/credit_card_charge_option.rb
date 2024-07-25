require 'xendit_api/model/base'

module XenditApi
  module Model
    class CreditCardChargeOption < XenditApi::Model::Base
      attr_accessor :business_id,
                    :installments,
                    :bin,
                    :promotions
    end
  end
end
