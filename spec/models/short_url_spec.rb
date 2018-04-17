require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe '#set_key' do
    context 'Create' do
      it 'set a key that length is 8' do
        short_url = Fabricate :short_url
        expect(short_url.key.length).to eq 8
      end

      it 'set a key when length is specified' do
        short_url = Fabricate :short_url, length: 5
        expect(short_url.key.length).to eq 5
      end

      it 'set a key when char_set is specified' do
        short_url = Fabricate :short_url, char_set: ['A-Z', 'a-z', 'invalid']
        expect(short_url.key.match(/[a-zA-Z]+/).to_s).to eq short_url.key
      end

      it 'set a key when char_set is custom_key' do
        short_url = Fabricate :short_url, length: 5, custom_key: 'abcdefg'
        expect(short_url.key).to eq 'abcdefg'
      end
    end
  end

  context 'Update' do
    let!(:short_url) { Fabricate :short_url }

    it 'doesnt update key if limit_settings is not updated' do
      expect {
        short_url.update destination: 'http://new/xx'
      }.not_to change { short_url.key }
    end

    it 'updates key if limit_settings is updated' do
      expect {
        short_url.update length: 10
      }.to change { short_url.key }
      expect(short_url.key.length).to eq 10
    end
  end
end
