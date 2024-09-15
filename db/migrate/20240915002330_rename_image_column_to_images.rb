class RenameImageColumnToImages < ActiveRecord::Migration[7.1]
  def change
    rename_column :properties, :image, :images
  end
end