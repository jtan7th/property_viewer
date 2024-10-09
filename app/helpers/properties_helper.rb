module PropertiesHelper
    def suburb_pill(suburb)
      suburb = suburb.strip.downcase
      case suburb
      when "corsair bay"
        pill_class = "bg-green-50 text-green-600"
      when "lyttelton"
        pill_class = "bg-green-50 text-green-600"
      when "cass bay"
        pill_class = "bg-blue-50 text-blue-600"
      else
        return suburb.titleize # Return regular text for non-special suburbs
      end
  
      content_tag :span, suburb.titleize, class: "inline-flex items-center rounded-full #{pill_class} px-2 py-1 text-sm font-medium bg-opacity-50"
    end

    def suburb_options
      Property.distinct_suburbs
    end
  end