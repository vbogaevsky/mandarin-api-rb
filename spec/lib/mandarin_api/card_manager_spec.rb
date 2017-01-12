RSpec.describe MandarinApi::CardManager do
  let(:card_manager) { MandarinApi::CardManager.new }
  let(:merchant_id) { 234 }
  let(:secret) { 'secret' }
  let(:user) { User.new('ololo@gmail.com', '8-909-999-88-77') }
  let(:urls) do
    {
      return: 'https://www.ololol.com',
      callback: 'https://www.ololol.com/callbacks'
    }
  end

  User = Struct.new('User', :email, :phone)
  describe 'assign_card' do
    let(:params) do
      { customer_info: { email: 'ololo@gmail.com', phone: '+79099998877' },
        urls: {
          return: 'https://www.ololol.com',
          callback: 'https://www.ololol.com/callbacks'
        }
      }
    end
    it 'calls wrapper instance with args' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/card-bindings', params)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/card-bindings', params)
      card_manager.assign_card user, urls
    end
  end

  describe 'oneside_assign_card' do
    let(:card) { '4012888888881881' }
    let(:params) do
      { customer_info: { email: 'ololo@gmail.com', phone: '8-909-999-88-77' },
        target: { known_card_number: card } }
    end
    it 'calls wrapper instance with args' do
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/card-bindings', params)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/card-bindings', params)
      card_manager.one_side_assign_card user, card
    end
  end

  describe 'phone' do
    it 'serializes phone' do
      expect(card_manager.send(:phone, user)).to eq '+79099998877'
    end
  end
end
