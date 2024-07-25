require 'spec_helper'
require 'xendit_api/api/credit_card_charge_option'
require 'xendit_api/client'

RSpec.describe XenditApi::Api::CreditCardChargeOption do
  let(:client) { XenditApi::Client.new('xnd_public_development_av4KBmh8AWFzxqIFkv_19wKE1qh4rgUxAhd8DOmSmefDpczRCFYsn1pK3u4yfV3') }
  let(:credit_card_charge_option) { described_class.new(client) }

  describe '#get' do
    it 'end user’s card is eligible for installments' do
      VCR.use_cassette('xendit/credit_card_charge_option/get/success') do
        params = {
          amount: 1_000_000,
          bin: '552002',
          currency: 'IDR'
        }
        response = credit_card_charge_option.get(params)
        expect(response).not_to be_nil
        expect(response.bin).to eq '552002'
      end
    end
  end
end
