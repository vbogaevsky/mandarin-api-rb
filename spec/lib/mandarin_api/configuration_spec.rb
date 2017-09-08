RSpec.describe MandarinApi::Configuration do
  let(:config) { MandarinApi::Configuration.new }
  describe '#merchant_id=' do
    it 'can set value' do
      config.merchant_id = 123
      expect(config.merchant_id).to eq 123
    end
  end
  describe '#secret=' do
    it 'can set value' do
      config.secret = 'secret'
      expect(config.secret).to eq 'secret'
    end
  end
  describe '#request_url=' do
    it 'can set value' do
      config.request_url = 'www.google.com'
      expect(config.request_url).to eq 'www.google.com'
    end
  end
  describe '#logger=' do
    it 'can set value' do
      config.logger = Logger
      expect(config.logger).to eq Logger
    end
  end
end
