module PropertiesHelper
    def suburb_pill(suburb)
      suburb = suburb.strip.downcase
      case suburb
      when "corsair bay"
        pill_class = "bg-purple-50 text-purple-600"
      when "cass bay"
        pill_class = "bg-fuchsia-50 text-fuchsia-600"
      when "redcliffs"
        pill_class = "bg-red-50 text-red-600"
      when "clifton"
        pill_class = "bg-amber-50 text-amber-600"
      when "richmond hill"
        pill_class = "bg-green-50 text-green-600"
      when "moncks bay"
        pill_class = "bg-lime-50 text-lime-600"
      when "sumner"
        pill_class = "bg-blue-50 text-blue-600"
      when "mount pleasant"
        pill_class = "bg-cyan-50 text-cyan-600"
      when "scarborough"
        pill_class = "bg-orange-50 text-orange-600"
      else
        return suburb.titleize # Return regular text for non-special suburbs
      end

      link_to suburb.titleize, 
              properties_path(suburb: suburb),
              class: "inline-flex items-center rounded-full #{pill_class} px-2 py-1 text-sm font-medium bg-opacity-50 cursor-pointer suburb-pill",
              data: { turbo_frame: "properties" }
    end

    def suburb_options
      Property.distinct_suburbs
    end
  end