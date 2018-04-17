class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|
      t.string :destination
      t.integer :travel_count, default: 0
      t.string :key, index: true, unique: true
      t.jsonb :limit_settings, default: {}

      t.timestamps
    end
  end
end
