require 'rails_helper'

RSpec.describe Api::V1::ShortUrlsController, type: :controller do
  let!(:api_application) { Fabricate :api_application }

  before do
    request.headers['PRIVATE-TOKEN'] = api_application.private_token
    request.headers['HTTP_ACCEPT'] = 'application/json'
  end

  describe 'POST create' do
    let(:valid_attrs) { Fabricate.attributes_for :short_url }
    let(:invalid_attrs) { Fabricate.attributes_for :short_url, destination: nil }

    context 'with valid attrs' do
      it 'creates a new short_url' do
        expect {
          post :create, params: valid_attrs
        }.to change { api_application.short_urls.count }.by 1
      end
    end

    context 'with invalid attrs' do
      it 'doesnt create a new short_url' do
        expect {
          post :create, params: invalid_attrs
        }.not_to change { api_application.short_urls.count }
      end
    end
  end
end
