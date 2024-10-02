module StatsHelper
  def median_sale_price(properties)
    properties.median(:sale_price)
  end

  def median_homes_estimate_price(properties)
    properties.median(:homes_estimate_price)
  end

  def average_square_meters(properties)
    return 0 if properties.empty?
    
    total_floor_area = properties.sum(:floor_area)
    (total_floor_area.to_f / properties.count).round
  end

  def average_price_per_square_meter(properties)
    return 0 if properties.empty?
    
    total_price = properties.sum(:sale_price)
    total_floor_area = properties.sum(:floor_area)
    
    return 0 if total_floor_area == 0
    
    (total_price.to_f / total_floor_area).round(2)
  end
end