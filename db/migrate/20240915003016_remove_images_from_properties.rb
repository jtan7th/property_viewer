class RemoveImagesFromProperties < ActiveRecord::Migration[7.1]
  def change
    remove_column :properties, :images, :string
  end
end
