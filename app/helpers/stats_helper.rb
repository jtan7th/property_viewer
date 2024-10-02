module StatsHelper
  def median_sale_price(properties)
    properties.median(:sale_price)
  end

  def median_homes_estimate_price(properties)
    properties.median(:homes_estimate_price)
  end

  def average_square_meters(properties)
    properties_with_floor_area = properties.where.not(floor_area: nil)
    return 0 if properties_with_floor_area.empty?
    
    total_floor_area = properties_with_floor_area.sum(:floor_area)
    (total_floor_area.to_f / properties_with_floor_area.count).round
  end

  def average_price_per_square_meter(properties)
    properties_with_floor_area = properties.where.not(floor_area: nil)
    return 0 if properties_with_floor_area.empty?
    
    total_price = properties_with_floor_area.sum(:sale_price)
    total_floor_area = properties_with_floor_area.sum(:floor_area)
    
    return 0 if total_floor_area == 0
    
    (total_price.to_f / total_floor_area).round(2)
  end
end