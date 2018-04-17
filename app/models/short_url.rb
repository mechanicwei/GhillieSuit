class ShortUrl < ApplicationRecord
  DEFAULT_URL_LENGTH = 8

  VALID_CHAR_SET_MAP = {
    'A-Z' => ('A'..'Z').to_a,
    'a-z' => ('a'..'z').to_a,
    '0-9' => (0..9).to_a,
    '-'   => ['-'],
    '_'   => ['_'],
  }.freeze
  VALID_CHAR_SET = VALID_CHAR_SET_MAP.keys

  validates :destination, presence: true
  validates :key, presence: true, uniqueness: true

  before_validation :set_key

  store_accessor :limit_settings, :length, :char_set, :custom_key

  private

  def set_key
    return if persisted? && !will_save_change_to_attribute?(:limit_settings)

    self.key = custom_key.presence || generate_uniq_key
  end

  def generate_uniq_key
    _total_chars = total_chars
    while true do
      unique_key = generate_key(_total_chars)
      break unique_key unless self.class.exists?(key: unique_key)
    end
  end

  def generate_key(chars)
    key_length = length.presence || DEFAULT_URL_LENGTH
    chars.sample(key_length.to_i).join
  end

  def total_chars
    _char_set = Array.wrap(char_set) & VALID_CHAR_SET
    _char_set = _char_set.presence || VALID_CHAR_SET

    _char_set.map { |item| VALID_CHAR_SET_MAP[item] }.flatten
  end
end
