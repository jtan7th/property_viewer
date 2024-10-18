class AddLastUpdatedToProperties < ActiveRecord::Migration[6.1]
  def change
    add_column :properties, :last_updated, :datetime
  end
end