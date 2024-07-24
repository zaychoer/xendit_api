require 'spec_helper'
require 'xendit_api/api/payment_request'
require 'xendit_api/errors/payment_request'
require 'xendit_api/client'

RSpec.describe XenditApi::Api::PaymentRequest do
  let(:client) { XenditApi::Client.new('xnd_development_oDjdREFnGLMrXV2PRIpcui5m9NNb00IfrweTBDMWauzk6SqaUaWxpxXB8qubECk') }
  let(:payment_request) { described_class.new(client) }

  describe '#post' do
    context 'with valid params virtual account' do
      let(:params) do
        {
          currency: 'IDR',
          amount: 100_000,
          payment_method: {
            type: 'VIRTUAL_ACCOUNT',
            reusability: 'ONE_TIME_USE',
            reference_id: 'pm-level-33a918bb-0cc3-4b27-8206-5425b375f1ac',
            virtual_account: {
              channel_code: 'BRI',
              channel_properties: {
                customer_name: 'John Doe'
              }
            }
          },
          metadata: {
            sku: 'ABCDEFGH'
          }
        }
      end

      it 'returns success response' do
        VCR.use_cassette('xendit/payment_request/virtual_account/success') do
          headers = {
            IDEMPOTENCY_KEY: 'idempotency-key-123456789',
            for_user_id: '667d15f3e07834e30a69ff45'
          }
          response = payment_request.post(params, headers)

          expect(response).to be_instance_of XenditApi::Model::PaymentRequest
          expect(response.payment_method['type']).to eq 'VIRTUAL_ACCOUNT'
          expect(response.payment_method['reusability']).to eq 'ONE_TIME_USE'
          expect(response.payment_method['virtual_account']['amount']).to eq 100_000
          expect(response.payment_method['virtual_account']['channel_code']).to eq 'BRI'
        end
      end
    end

    context 'with invalid params virtual account' do
      let(:params) do
        {
          currency: 'IDR',
          amount: 100_000,
          payment_method: {
            type: '',
            reusability: 'ONE_TIME_USE',
            reference_id: 'pm-level-33a918bb-0cc3-4b27-8206-5425b375f1ac',
            virtual_account: {
              channel_code: 'BRI',
              channel_properties: {
                customer_name: 'John Doe'
              }
            }
          },
          metadata: {
            sku: 'ABCDEFGH'
          }
        }
      end

      it 'raise error xendit validation' do
        VCR.use_cassette('xendit/payment_request/virtual_account/validation_error') do
          headers = {
            IDEMPOTENCY_KEY: 'idempotency-key-1234567891',
            for_user_id: '667d15f3e07834e30a69ff45'
          }
          expect do
            payment_request.post(params, headers)
          end.to raise_error do |error|
            expect(error).to be_a XenditApi::Errors::ApiValidation
            expect(error.message).to eq 'Validation error'
          end
        end
      end
    end

    context 'with valid params qr code' do
      let(:params) do
        {
          amount: 15_000,
          currency: 'IDR',
          payment_method: {
            type: 'QR_CODE',
            reusability: 'ONE_TIM_USE',
            qr_code: {
              channel_code: 'DANA'
            }
          },
          description: 'sample description',
          metadata: {
            foo: 'bar'
          }
        }
      end

      it 'returns success response' do
        VCR.use_cassette('xendit/payment_request/qr_code/success') do
          headers = {
            IDEMPOTENCY_KEY: 'idempotency-key-1234567892',
            for_user_id: '667d15f3e07834e30a69ff45'
          }
          response = payment_request.post(params, headers)

          expect(response).to be_instance_of XenditApi::Model::PaymentRequest
          expect(response.payment_method['type']).to eq 'QR_CODE'
          expect(response.payment_method['reusability']).to eq 'ONE_TIME_USE'
          expect(response.payment_method['qr_code']['amount']).to eq 15_000
          expect(response.payment_method['qr_code']['channel_code']).to eq 'DANA'
        end
      end
    end

    context 'with invalid params qr code' do
      let(:params) do
        {
          amount: 15_000,
          currency: 'IDR',
          payment_method: {
            type: '',
            reusability: 'ONE_TIME_USE',
            qr_code: {
              channel_code: 'DANA'
            }
          },
          description: 'sample description',
          metadata: {
            foo: 'bar'
          }
        }
      end

      it 'raise error xendit validation' do
        VCR.use_cassette('xendit/payment_request/qr_code/validation_error') do
          headers = {
            IDEMPOTENCY_KEY: 'idempotency-key-1234567893',
            for_user_id: '667d15f3e07834e30a69ff45'
          }
          expect do
            payment_request.post(params, headers)
          end.to raise_error do |error|
            expect(error).to be_a XenditApi::Errors::ApiValidation
            expect(error.message).to eq 'Validation error'
          end
        end
      end
    end

    context 'with valid params ewallet' do
      let(:params) do
        {
          country: 'ID',
          currency: 'IDR',
          amount: 1500,
          customer_id: 'cust-bd0c59cd-5225-4e3f-a8d6-47d1783832e5',
          payment_method: {
            type: 'EWALLET',
            reusability: 'ONE_TIME_USE',
            ewallet: {
              channel_code: 'SHOPEEPAY',
              channel_properties: {
                success_return_url: 'https://redirect.me/goodstuff',
                failure_return_url: 'https://redirect.me/badstuff'
              }
            }
          },
          metadata: {
            sku: 'ABCDEFGH'
          }
        }
      end

      it 'returns success response' do
        VCR.use_cassette('xendit/payment_request/ewallet/success') do
          headers = {
            IDEMPOTENCY_KEY: 'idempotency-key-1234567895',
            for_user_id: '667d15f3e07834e30a69ff45'
          }
          response = payment_request.post(params, headers)

          expect(response).to be_instance_of XenditApi::Model::PaymentRequest
          expect(response.payment_method['type']).to eq 'EWALLET'
          expect(response.payment_method['reusability']).to eq 'ONE_TIME_USE'
          expect(response.amount).to eq 1500
          expect(response.payment_method['ewallet']['channel_code']).to eq 'SHOPEEPAY'
        end
      end
    end

    context 'with invalid params ewallet' do
      let(:params) do
        {
          country: 'ID',
          currency: 'IDR',
          amount: 1500,
          customer_id: 'cust-bd0c59cd-5225-4e3f-a8d6-47d1783832e5',
          payment_method: {
            type: '',
            reusability: 'ONE_TIME_USE',
            ewallet: {
              channel_code: 'SHOPEEPAY',
              channel_properties: {
                success_return_url: 'https://redirect.me/goodstuff',
                failure_return_url: 'https://redirect.me/badstuff'
              }
            }
          },
          metadata: {
            sku: 'ABCDEFGH'
          }
        }
      end

      it 'returns success response' do
        VCR.use_cassette('xendit/payment_request/ewallet/validation_error') do
          headers = {
            IDEMPOTENCY_KEY: 'idempotency-key-1234567896',
            for_user_id: '667d15f3e07834e30a69ff45'
          }
          expect do
            payment_request.post(params, headers)
          end.to raise_error do |error|
            expect(error).to be_a XenditApi::Errors::ApiValidation
            expect(error.message).to eq 'Validation error'
          end
        end
      end
    end
  end
end
