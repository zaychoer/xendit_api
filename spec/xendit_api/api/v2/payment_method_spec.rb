require 'spec_helper'
require 'xendit_api/api/v2/payment_method'
require 'xendit_api/errors/v2/payment_method'
require 'xendit_api/client'

RSpec.describe XenditApi::Api::V2::PaymentMethod do
  let(:client) { XenditApi::Client.new('xnd_development_oDjdREFnGLMrXV2PRIpcui5m9NNb00IfrweTBDMWauzk6SqaUaWxpxXB8qubECk')}
  let(:payment_method) { described_class.new(client) }

  describe '#post' do
    context 'with valid params virtual account' do
      let(:params) do
        {
          type: 'VIRTUAL_ACCOUNT',
          virtual_account: {
            amount: 100_000,
            currency: 'IDR',
            channel_code: 'BSI',
            channel_properties: {
              customer_name: 'John Doe',
              expires_at: '2024-07-04T06:47:23.784379Z'
            }
          },
          reusability: 'ONE_TIME_USE',
          metadata: {
            branch_code: 'ABC123'
          }
        }
      end

      it 'returns success response' do
        VCR.use_cassette('xendit/v2/payment_method/virtual_account/success') do
          response = payment_method.post(params: params)

          expect(response).to be_instance_of XenditApi::Model::V2::PaymentMethod
          expect(response.type).to eq 'VIRTUAL_ACCOUNT'
          expect(response.reusability).to eq 'ONE_TIME_USE'
        end
      end
    end

    context 'with invalid params virtual account' do
      let(:params) do
        {
          type: 'VIRTUAL_ACCOUNT',
          reusability: 'ONE_TIME_USE',
          metadata: {
            branch_code: 'ABC123'
          }
        }
      end

      it 'raise error xendit validation' do
        VCR.use_cassette('xendit/v2/payment_method/virtual_account/validation_error') do
          expect do
            payment_method.post(params: params)
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
              type: "QR_CODE",
              reusability: "ONE_TIME_USE",
              qr_code: {
                  amount: 1000,
                  currency: "IDR",
                  channel_code: "DANA"
              }
            }
          end

          it 'returns success response' do
            VCR.use_cassette('xendit/v2/payment_method/qr_code/success') do
              response = payment_method.post(params: params)

              expect(response).to be_instance_of XenditApi::Model::V2::PaymentMethod
              expect(response.type).to eq 'QR_CODE'
              expect(response.reusability).to eq 'ONE_TIME_USE'
            end
          end
        end

        context 'with invalid params qr code' do
          let(:params) do
            {
              type: 'QR_CODE',
              reusability: 'ONE_TIME_USE',
            }
          end

          it 'raise error xendit validation' do
            VCR.use_cassette('xendit/v2/payment_method/qr_code/validation_error') do
              expect do
                payment_method.post(params: params)
              end.to raise_error do |error|
                expect(error).to be_a XenditApi::Errors::ApiValidation
                expect(error.message).to eq 'Validation error'
              end
            end
          end
        end
  end
end
