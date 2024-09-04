require 'spec_helper'
require 'xendit_api/api/v2/simulate_payment'
require 'xendit_api/errors/v2/simulate_payment'
require 'xendit_api/client'

RSpec.describe XenditApi::Api::V2::SimulatePayment do
  let(:client) { XenditApi::Client.new('xnd_development_oDjdREFnGLMrXV2PRIpcui5m9NNb00IfrweTBDMWauzk6SqaUaWxpxXB8qubECk') }
  let(:simulate_payment) { described_class.new(client) }

  describe '#post' do
    context 'with valid params' do
      let(:params) do
        { amount: 55_200 }
      end
      let(:id) { 'pm-6444ca47-f441-415c-b169-ebdb2a52ab08' }

      it 'returns success response' do
        VCR.use_cassette('xendit/v2/simulate_payment/success') do
          headers = {
            for_user_id: '667d15f3e07834e30a69ff45'
          }
          response = simulate_payment.post(params, id, headers)

          expect(response).to be_instance_of XenditApi::Model::V2::SimulatePayment
          expect(response.status).to eq 'PENDING'
        end
      end
    end
  end
end
