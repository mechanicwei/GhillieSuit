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

    context 'with invalid attrs' do
      it 'doesnt create a new short_url' do
        expect {
          post :create, params: { short_url: invalid_attrs }
        }.not_to change { ShortUrl.count }
      end
    end
  end

  describe 'GET show' do
    let!(:short_url) { Fabricate :short_url }

    it 'returns http success' do
      get :show, params: { id: short_url.id }
      expect(response.status).to eq 200
    end
  end

  describe 'GET edit' do
    let!(:short_url) { Fabricate :short_url }

    it 'returns http success' do
      get :edit, params: { id: short_url.id }
      expect(response.status).to eq 200
    end
  end

  describe 'PATCH update' do
    let!(:short_url) { Fabricate :short_url }
    let(:valid_attrs) { Fabricate.attributes_for :short_url, destination: 'http://new' }
    let(:invalid_attrs) { Fabricate.attributes_for :short_url, destination: nil }

    context 'with valid attrs' do
      it 'updates the short_url' do
        post :update, params: { id: short_url.id, short_url: valid_attrs }
        expect(short_url.reload.destination).to eq 'http://new'
      end
    end

    context 'with invalid attrs' do
      it 'doesnt update the short_url' do
        expect {
          post :update, params: { id: short_url.id, short_url: invalid_attrs }
        }.not_to change { short_url.reload.destination }
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:short_url) { Fabricate :short_url }

    it 'deletes teh short_url' do
      expect {
        delete :destroy, params: { id: short_url.id }
      }.to change { ShortUrl.count }.by -1
    end
  end
end
