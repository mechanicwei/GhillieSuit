class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|
      t.string :destination
      t.integer :travel_count, default: 0
      t.string :key
      t.jsonb :limit_settings, default: {}

      t.timestamps
    end

    add_index :short_urls, :key, unique: true
  end
end
