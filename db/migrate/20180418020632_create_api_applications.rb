class CreateApiApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :api_applications do |t|
      t.string :private_token

      t.timestamps
    end

    add_belongs_to :short_urls, :api_application
  end
end
