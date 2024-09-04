require 'xendit_api/model/base'

module XenditApi
  module Model
    module V2
      class SimulatePayment < XenditApi::Model::Base
        attr_accessor :status,
                      :message
      end
    end
  end
end
