class AddImageUrlsToProperties < ActiveRecord::Migration[6.1]
  def change
    add_column :properties, :image_urls, :string, array: true, default: []
  end
end