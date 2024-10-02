module StatsHelper
  def median_sale_price(properties)
    properties.median(:sale_price)
  end

  def median_homes_estimate_price(properties)
    properties.median(:homes_estimate_price)
  end
end