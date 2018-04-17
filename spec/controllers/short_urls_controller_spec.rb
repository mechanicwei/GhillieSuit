require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do
  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response.status).to eq 200
    end
  end
end
