json.(@short_url, :id, :destination, :travel_count, :key)
json.short_url travel_url(key: @short_url.key)
json.(@short_url, :length, :char_set, :custom_key)
