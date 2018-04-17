class ShortUrl < ApplicationRecord
  validates :destination, presence: true
  validates :key, presence: true, uniqueness: true

  store_accessor :limit_settings, :length, :char_set, :custom_key
end
