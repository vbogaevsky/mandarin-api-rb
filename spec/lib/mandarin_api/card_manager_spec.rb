RSpec.describe MandarinApi::CardManager do
  describe 'assign_card' do
    let(:card_manager) { MandarinApi::CardManager.new }
    let(:merchant_id) { 234 }
    let(:secret) { 'secret' }
    let(:params) do
      { customer_info: { email: 'ololo@gmail.com', phone: '8-909-999-88-77' } }
    end
    it 'calls wrapper instance with args' do
      User = Struct.new('User', :email, :phone)
      user = User.new('ololo@gmail.com', '8-909-999-88-77')
      allow(MandarinApi).to \
        receive_message_chain(:config, :merchant_id).and_return(merchant_id)
      allow(MandarinApi).to \
        receive_message_chain(:config, :secret).and_return(merchant_id)
      allow_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/card-bindings', params)
      expect_any_instance_of(MandarinApi::Wrapper).to receive(:request)
        .with('/api/card-bindings', params)
      card_manager.assign_card user
    end
  end
end
