module PropertiesHelper
    def suburb_pill(suburb)
      suburb = suburb.strip.downcase
      case suburb
      when "corsair bay"
        pill_class = "bg-green-100 text-green-700"
      when "lyttelton"
        pill_class = "bg-green-100 text-green-700"
      when "cass bay"
        pill_class = "bg-blue-100 text-blue-700"
      else
        return suburb.titleize # Return regular text for non-special suburbs
      end
  
      content_tag :span, suburb.titleize, class: "inline-flex items-center rounded-full #{pill_class} px-2 py-1 text-sm font-medium"
    end
  end