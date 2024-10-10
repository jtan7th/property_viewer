class AddImageFieldsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :image_download_in_progress, :boolean
    add_column :properties, :image_download_failed, :boolean
  end
end
