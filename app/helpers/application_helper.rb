module ApplicationHelper
  include Pagy::Frontend

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

  def format_area(area)
    return 'N/A' if area.nil?
    "#{area} m²"
  end

  def nav_link_class(path)
    if current_page?(path)
      "border-b-2 border-b-indigo-500 text-gray-900"
    else
      "border-b-2 border-b-transparent text-gray-500 hover:border-b-gray-300 hover:text-gray-700"
    end
  end
end
