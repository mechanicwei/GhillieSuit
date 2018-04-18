class ShortUrl < ApplicationRecord
  DEFAULT_URL_LENGTH = 8
  URL_LENGTH_RANGE = 5..20

  VALID_CHAR_SET_MAP = {
    'A-Z' => ('A'..'Z').to_a,
    'a-z' => ('a'..'z').to_a,
    '0-9' => (0..9).to_a,
    '-'   => ['-'],
    '_'   => ['_'],
  }.freeze
  VALID_CHAR_SET = VALID_CHAR_SET_MAP.keys

  validates :destination, presence: true
  validates :key, presence: true, uniqueness: true, length: { in: URL_LENGTH_RANGE }

  before_validation :set_key

  store_accessor :limit_settings, :length, :char_set, :custom_key

  private

  def set_key
    return if persisted? && !will_save_change_to_attribute?(:limit_settings)

    self.key = custom_key.presence || generate_uniq_key
  end

  def generate_uniq_key
    _total_chars = total_chars
    unique_key = nil
    generate_count = 0

    while generate_count < 10 do
      unique_key = generate_key(_total_chars)
      if self.class.exists?(key: unique_key)
        unique_key = nil
        generate_count += 1
      else
        break
      end
    end

    unless unique_key
      errors.add(:base, '无法找到可用的短连接')
    end

    unique_key
  end

  def generate_key(chars)
    chars.sample(key_length).join
  end

  def total_chars
    _char_set = Array.wrap(char_set) & VALID_CHAR_SET
    _char_set = _char_set.presence || VALID_CHAR_SET

    _char_set.map { |item| VALID_CHAR_SET_MAP[item] }.flatten
  end

  def key_length
    if length.present? && URL_LENGTH_RANGE.include?(length.to_i)
      length.to_i
    else
      DEFAULT_URL_LENGTH
    end
  end
end
