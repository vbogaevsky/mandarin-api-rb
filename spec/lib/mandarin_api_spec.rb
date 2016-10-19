# frozen_string_literal: true
require 'spec_helper'

RSpec.describe MandarinApi do
  describe '#configure' do
    let(:wrapper) do
      MandarinApi::Wrapper.new(merchant_id: MandarinApi.config.merchant_id,
                               secret: MandarinApi.config.secret)
    end
    before do
      MandarinApi.configure do |config|
        config.merchant_id = 123
        config.secret = 'secret'
      end
    end
    it 'calls MandarinApi::CardManager' do
      expect(wrapper.instance_variable_get(:@merchant_id)).to eq 123
      expect(wrapper.instance_variable_get(:@secret)).to eq 'secret'
    end
  end
end
