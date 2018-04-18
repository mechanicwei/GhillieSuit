class ApiApplication < ApplicationRecord
  has_many :short_urls, dependent: :destroy

  before_create :set_private_token

  private

  def set_private_token
    self.private_token ||= generate_token
  end

  def generate_token
    begin
      token = SecureRandom.urlsafe_base64(24).tr('-_=', 'fAh')
    end while self.class.exists?(private_token: token)
    token
  end
end
