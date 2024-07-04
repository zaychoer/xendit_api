require 'spec_helper'

RSpec.describe XenditApi::Api::Customer do
  let(:client) { XenditApi::Client.new('xnd_development_oDjdREFnGLMrXV2PRIpcui5m9NNb00IfrweTBDMWauzk6SqaUaWxpxXB8qubECk') }

  describe '#create' do
    it 'returns expected response' do
      VCR.use_cassette('xendit/customer/create/success') do
        customer_api = described_class.new(client)
        headers = {
          for_user_id: '667d15f3e07834e30a69ff45',
          IDEMPOTENCY_KEY: 'idempotency-key-1234567895',
          API_Version: '2020-10-31'
        }
        params = {
          reference_id: 'reference-id-1234567895',
          type: 'INDIVIDUAL',
          individual_detail: {
            given_names: 'John',
            surname: 'Doe'
          },
          email: 'testemail@email.com',
          mobile_number: '+628774494404'
        }
        response = customer_api.create(params, headers)

        expect(response).to be_instance_of XenditApi::Model::Customer
      end
    end

    it 'returns duplicate reference id' do
      VCR.use_cassette('xendit/customer/create/duplicate_error') do
        customer_api = described_class.new(client)
        headers = {
          for_user_id: '667d15f3e07834e30a69ff45',
          IDEMPOTENCY_KEY: 'idempotency-key-1234567896',
          API_Version: '2020-10-31'
        }
        params = {
          reference_id: 'reference-id-1234567895',
          type: 'INDIVIDUAL',
          individual_detail: {
            given_names: 'John',
            surname: 'Doe'
          },
          email: 'testemail@email.com',
          mobile_number: '+628774494404'
        }

        expect do
          customer_api.create(params, headers)
        end.to raise_error do |error|
          expect(error).to be_a XenditApi::Errors::DuplicateError
          expect(error.message).to eq 'The reference_id entered has been used before. Please enter a unique reference_id'
        end
      end
    end

    it 'returns idempotency error' do
      VCR.use_cassette('xendit/customer/create/idempotency_error') do
        customer_api = described_class.new(client)
        headers = {
          for_user_id: '667d15f3e07834e30a69ff45',
          IDEMPOTENCY_KEY: 'idempotency-key-1234567895',
          API_Version: '2020-10-31'
        }
        params = {
          reference_id: 'reference-id-1234567896',
          type: 'INDIVIDUAL',
          individual_detail: {
            given_names: 'John',
            surname: 'Doe'
          },
          email: 'testemail@email.com',
          mobile_number: '+628774494404'
        }

        expect do
          customer_api.create(params, headers)
        end.to raise_error do |error|
          expect(error).to be_a XenditApi::Errors::IdempotencyError
        end
      end
    end
  end

  describe '#get_by_reference_id' do
    it 'returns expected response' do
      VCR.use_cassette('xendit/customer/get_by_reference_id/success') do
        customer_api = described_class.new(client)
        headers = {
          for_user_id: '667d15f3e07834e30a69ff45',
          API_Version: '2020-10-31'
        }
        reference_id = 'reference-id-1234567895'
        response = customer_api.get_by_reference_id(reference_id, headers)

        expect(response).to be_instance_of XenditApi::Model::Customer
        expect(response.reference_id).to eq 'reference-id-1234567895'
      end
    end
  end
end
