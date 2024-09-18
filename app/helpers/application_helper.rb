module ApplicationHelper
  def format_price(price)
    return 'N/A' if price.nil?
    return 'TBC' if price == 'TBC'

    case price.to_s.length
    when 1..5
      number_to_currency(price)
    when 6
      "$#{price / 1000}k"
    when 7
      "$#{(price / 1000000.0).round(3)}m"
    else
      number_to_currency(price)
    end
  end
end
