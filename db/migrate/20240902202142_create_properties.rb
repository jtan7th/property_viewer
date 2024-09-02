class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :url
      t.string :address
      t.string :sale_price
      t.date :sold_date
      t.date :homes_estimate_date
      t.string :homes_estimate_price
      t.string :homes_estimate_range_low
      t.string :homes_estimate_range_high
      t.integer :bedroom_count
      t.integer :bathroom_count
      t.integer :carpark_spaces_count
      t.string :floor_area
      t.string :land_area
      t.string :deck
      t.string :property_contour
      t.string :view_type
      t.string :decade_built
      t.string :view_living_area
      t.string :condition
      t.string :suburb
      t.string :capital_valuation
      t.date :capital_valuation_date
      t.string :land_value
      t.string :improvement_value

      t.timestamps
    end
  end
end
