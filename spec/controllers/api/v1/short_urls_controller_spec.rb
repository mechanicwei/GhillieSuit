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

  describe 'PATCH update' do
    let!(:short_url) { Fabricate :short_url, api_application: api_application }
    let(:valid_attrs) { Fabricate.attributes_for :short_url, destination: 'http://new' }
    let(:invalid_attrs) { Fabricate.attributes_for :short_url, destination: nil }

    context 'with valid attrs' do
      it 'updates the short_url' do
        post :update, params: valid_attrs.merge(id: short_url.id)
        expect(short_url.reload.destination).to eq 'http://new'
      end
    end

    context 'with invalid attrs' do
      it 'doesnt update the short_url' do
        expect {
          post :update, params: invalid_attrs.merge(id: short_url.id)
        }.not_to change { short_url.reload.destination }
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:short_url) { Fabricate :short_url, api_application: api_application }

    it 'deletes teh short_url' do
      expect {
        delete :destroy, params: { id: short_url.id }
      }.to change { ShortUrl.count }.by -1
    end
  end

  describe 'GET show' do
    let!(:short_url) { Fabricate :short_url, api_application: api_application }

    it 'return http success' do
      get :show, params: { id: short_url.id }
      expect(response.status).to eq 200
    end
  end
end
