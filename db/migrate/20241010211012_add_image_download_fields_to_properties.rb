class AddImageDownloadFieldsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :download_job_id, :string
    add_column :properties, :expected_image_count, :integer
  end
end
