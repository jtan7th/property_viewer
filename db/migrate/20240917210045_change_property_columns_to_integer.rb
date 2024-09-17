class ChangePropertyColumnsToInteger < ActiveRecord::Migration[7.1]
  def up
    change_column :properties, :sale_price, :integer, using: 'NULLIF(sale_price, \'\')::integer'
    change_column :properties, :homes_estimate_price, :integer, using: 'NULLIF(homes_estimate_price, \'\')::integer'
    change_column :properties, :homes_estimate_range_low, :integer, using: 'NULLIF(homes_estimate_range_low, \'\')::integer'
    change_column :properties, :homes_estimate_range_high, :integer, using: 'NULLIF(homes_estimate_range_high, \'\')::integer'
    change_column :properties, :floor_area, :integer, using: 'NULLIF(floor_area, \'\')::integer'
    change_column :properties, :land_area, :integer, using: 'NULLIF(land_area, \'\')::integer'
    change_column :properties, :capital_valuation, :integer, using: 'NULLIF(capital_valuation, \'\')::integer'
    change_column :properties, :land_value, :integer, using: 'NULLIF(land_value, \'\')::integer'
    change_column :properties, :improvement_value, :integer, using: 'NULLIF(improvement_value, \'\')::integer'
  end

  def down
    change_column :properties, :sale_price, :string
    change_column :properties, :homes_estimate_price, :string
    change_column :properties, :homes_estimate_range_low, :string
    change_column :properties, :homes_estimate_range_high, :string
    change_column :properties, :floor_area, :string
    change_column :properties, :land_area, :string
    change_column :properties, :capital_valuation, :string
    change_column :properties, :land_value, :string
    change_column :properties, :improvement_value, :string
  end
end