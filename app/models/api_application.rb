class ApiApplication < ApplicationRecord
  has_many :short_urls, dependent: :destroy
end
