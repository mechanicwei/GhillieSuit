require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do
  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe 'POST create' do
    let(:valid_attrs) { Fabricate.attributes_for :short_url }
    let(:invalid_attrs) { Fabricate.attributes_for :short_url, destination: nil }

    context 'with valid attrs' do
      it 'creates a new short_url' do
        expect {
          post :create, params: { short_url: valid_attrs }
        }.to change { ShortUrl.count }.by 1
      end
    end

    context 'with valid attrs' do
      it 'doesnt create a new short_url' do
        expect {
          post :create, params: { short_url: invalid_attrs }
        }.not_to change { ShortUrl.count }
      end
    end
  end
end
