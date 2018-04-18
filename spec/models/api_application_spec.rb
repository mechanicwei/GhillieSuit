require 'rails_helper'

RSpec.describe ApiApplication, type: :model do
  describe '#set_private_token' do
    it 'set a private_token on create' do
      api_application = Fabricate :api_application, private_token: nil
      expect(api_application.private_token.present?).to eq true
    end
  end
end
